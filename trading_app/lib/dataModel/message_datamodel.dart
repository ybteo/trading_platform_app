class MessageModel{
  final String message;
  final String senderId;
  final String receiverId;
  final String senderEmail;
  final DateTime timestamp;

  MessageModel({
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.senderEmail,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'message': message,
    'senderId': senderId,
    'receiverId': receiverId,
    'senderEmail': senderEmail,
    'timestamp': timestamp,
  };

  factory MessageModel.fromJson(Map<String, dynamic> json)=> MessageModel(
    message: json['message'], 
    senderId: json['senderId'], 
    receiverId: json['receiverId'], 
    senderEmail: json['senderEmail'], 
    timestamp: DateTime.parse(json['timestamp']),
  );






}