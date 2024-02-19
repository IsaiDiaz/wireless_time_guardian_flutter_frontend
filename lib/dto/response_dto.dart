class ResponseDto<T> {
  final T data;
  final String message;
  final String code;

  ResponseDto({required this.data, required this.message, required this.code});

  factory ResponseDto.fromJson(Map<String, dynamic> json) {
    return ResponseDto(
      data: json['data'],
      message: json['message'],
      code: json['code'],
    );
  }
}
