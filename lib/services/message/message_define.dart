import 'dart:typed_data';
import 'dart:convert';
import 'dart:core';

final MAX_RECV_SIZE = 2 * 1024 * 1024;

abstract class BaseMessage{
  int? msgID;
  String? msgData;

  BaseMessage.newRMessage(Uint8List buf){
    var bLen = ByteData.view(buf.buffer).getInt32(0)>>2;
    if(bLen > MAX_RECV_SIZE) return;
    // var timeSv =  ByteData.view(buf.buffer).getInt32(4);
    // if((DateTime.now().millisecond - timeSv) < 0) return;
    msgID = ByteData.view(buf.buffer).getInt32(8);
    msgData = utf8.decode(buf.buffer.asInt8List(12));
  }

  BaseMessage.newSMessage(this.msgID,this.msgData);
  String toJsonString(){
    return msgData ?? "";
  }
  @override
  String toString(){
    return "{msgID=${msgID ?? 0},msgData=${msgData ?? ""}}";
  }
  Uint8List int32bytes(var value) =>
      Uint8List(4)..buffer.asByteData().setInt32(0, value, Endian.big);

}

/// class for received message
class RMessage extends BaseMessage{
  RMessage(Uint8List buffer) : super.newRMessage(buffer);

}

/// class for send message
class SMessage extends BaseMessage {
  SMessage(int msgID, String msgData) : super.newSMessage(msgID, msgData);

  Uint8List toByteBuf(){
    BytesBuilder builder = BytesBuilder();
    var bMsgData = utf8.encode(toJsonString());
    int bufLen = (bMsgData.length + 12)<<2; // shift left 2 bit
    builder.add(int32bytes(bufLen)); //bufLen
    builder.add(int32bytes(80000)); //time
    builder.add(int32bytes(msgID)); //msgId
    builder.add(bMsgData); //msgdata
    //------------DEBUG------------
    // ByteBuffer b = builder.toBytes().buffer;
    // print(ByteData.view(b).getInt32(0));
    // print(ByteData.view(b).getInt32(4));
    // print(ByteData.view(b).getInt32(8));
    // print(utf8.decode(b.asInt8List(12)));
    //-----------------------------
    return builder.toBytes();
  }
}