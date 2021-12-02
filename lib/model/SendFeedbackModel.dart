class SendFeedBackModel{
  final String id, email, subject, title, body;

  SendFeedBackModel({this.id, this.email, this.subject, this.title, this.body});

  SendFeedBackModel.fromData(Map<String, dynamic> data)
      : id = data['id'],
       email = data['email'],
       subject = data['subject'],
       title = data['title'],
       body = data['body'];

  Map<String, dynamic> toJson() {
    return {
       'id': id,
       'email': email,
       'subject': subject,
       'title' : title,
       'body' : body
       };
  }
}