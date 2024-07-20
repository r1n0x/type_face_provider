import 'dart:io';

extension FinishedProcess on Process {
  Future<int> get isFinished async => exitCode;
}
