class ResponseData {
  int status;
  String message;
  Data data;

  ResponseData({this.status, this.message, this.data});

  ResponseData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<String> texts;
  List<String> labels;
  List<Map<String, dynamic>> faces;
  List<Object> logos;

  Data({this.texts, this.labels, this.faces, this.logos});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["Texts"] != null) {
      texts = json['Texts'].cast<String>();
    }

    if (json["Labels"] != null) {
      labels = json['Labels'].cast<String>();
    }

    if (json["Faces"] != null) {
      faces = json['Faces'].cast<Map<String, dynamic>>();
    }

    if (json["Logos"] != null) {
      logos = json['Logos'].cast<Object>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Texts'] = this.texts;
    data['Labels'] = this.labels;
    data['Faces'] = this.faces;
    data['Logos'] = this.logos;
    return data;
  }
}
