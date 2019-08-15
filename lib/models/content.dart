class Content {
  final String id;
  final String isActive;
  final String createdBy;
  final String createdOn;
  final String updatedBy;
  final String updatedOn;

  Content({this.id, this.createdBy, this.createdOn, this.updatedBy, this.updatedOn, this.isActive});

  factory Content.fromJson(Map<String, dynamic> json){
    return Content(
        id: json['id'] as String,
        createdBy : json['createdBy'].toString(),
        createdOn : json['createdOn'].toString(),
        updatedBy : json['updatedBy'].toString(),
        updatedOn : json['updatedOn'].toString(),
        isActive : json['isActive'].toString(),
    );
  }
}