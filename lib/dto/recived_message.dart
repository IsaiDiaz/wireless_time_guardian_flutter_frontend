class RecivedMessage{
  String content;

  RecivedMessage({required this.content});

  factory RecivedMessage.fromJson(Map<String, dynamic> json) {
    return RecivedMessage(
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
    };
  }

  @override
  String toString() {
    return 'RecivedMessage{content: $content}';
  }
}