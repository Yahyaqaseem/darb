import {
  WebSocketGateway,
  WebSocketServer,
  SubscribeMessage,
  OnGatewayConnection,
  OnGatewayDisconnect,
  ConnectedSocket,
  MessageBody,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { RoadCallService } from './road-call.service';

@WebSocketGateway({
  cors: {
    origin: '*',
  },
  namespace: '/road-call',
})
export class RoadCallGateway implements OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  // Track which socket is on which segment
  private clientSegments = new Map<string, string>();

  constructor(private readonly roadCallService: RoadCallService) {}

  handleConnection(client: Socket) {
    console.log(`Client connected to Road Call: ${client.id}`);
  }

  handleDisconnect(client: Socket) {
    const segmentId = this.clientSegments.get(client.id);
    if (segmentId) {
      const count = this.roadCallService.leaveSegment(segmentId, client.id);
      this.clientSegments.delete(client.id);
      this.server.to(segmentId).emit('driverCountUpdated', { segmentId, count });
    }
  }

  @SubscribeMessage('joinRoadSegment')
  handleJoinSegment(
    @ConnectedSocket() client: Socket,
    @MessageBody() payload: { segmentId: string },
  ) {
    const { segmentId } = payload;
    
    // Leave previous segment if any
    const oldSegment = this.clientSegments.get(client.id);
    if (oldSegment) {
      client.leave(oldSegment);
      const oldCount = this.roadCallService.leaveSegment(oldSegment, client.id);
      this.server.to(oldSegment).emit('driverCountUpdated', { segmentId: oldSegment, count: oldCount });
    }

    // Join new segment
    client.join(segmentId);
    this.clientSegments.set(client.id, segmentId);
    const count = this.roadCallService.joinSegment(segmentId, client.id);

    // Broadcast to room
    this.server.to(segmentId).emit('driverCountUpdated', { segmentId, count });
    return { status: 'joined', segmentId, driversCount: count };
  }

  @SubscribeMessage('askQuestion')
  handleAskQuestion(
    @ConnectedSocket() client: Socket,
    @MessageBody() payload: { segmentId: string; question: string },
  ) {
    // Broadcast question to all drivers in the segment
    client.to(payload.segmentId).emit('newQuestion', {
      questionId: Date.now().toString(),
      question: payload.question,
      timestamp: new Date().toISOString(),
    });
  }

  @SubscribeMessage('answerQuestion')
  handleAnswerQuestion(
    @ConnectedSocket() client: Socket,
    @MessageBody() payload: { segmentId: string; questionId: string; answer: string },
  ) {
    // Broadcast answer aggregate
    this.server.to(payload.segmentId).emit('answerUpdate', {
      questionId: payload.questionId,
      answer: payload.answer,
    });
  }
}
