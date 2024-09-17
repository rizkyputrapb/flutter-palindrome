class ListInput {
  List<InputModel>? inputmodel;

  ListInput({this.inputmodel});

  ListInput.fromJson(Map<String, dynamic> json) {
    if (json['inputmodel'] != null) {
      inputmodel = <InputModel>[];
      json['inputmodel'].forEach((v) {
        inputmodel!.add(InputModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (inputmodel != null) {
      data['inputmodel'] = inputmodel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InputModel {
  int? id;
  String? input;
  bool? isPalindrome;

  InputModel({this.id, this.input, this.isPalindrome});

  InputModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    input = json['input'];
    isPalindrome = json['isPalindrome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['input'] = input;
    data['isPalindrome'] = isPalindrome;
    return data;
  }
}
