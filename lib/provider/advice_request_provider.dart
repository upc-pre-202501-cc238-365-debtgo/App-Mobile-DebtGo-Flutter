import 'package:flutter/material.dart';
import '../data/models/advice_request.dart';

class AdviceRequestProvider with ChangeNotifier {
  final List<AdviceRequest> _requests = [];

  List<AdviceRequest> get requests => _requests;

  void addRequest(AdviceRequest request) {
    _requests.add(request);
    notifyListeners();
  }
}