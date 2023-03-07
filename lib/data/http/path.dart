enum APIPath {
  workinggenbaname,
  getGenbaWorkTime,
  worktimemonthdata,
  worktimesummary,
}

extension APIPathExtension on APIPath {
  String? get value {
    switch (this) {
      case APIPath.workinggenbaname:
        return 'workinggenbaname';
      case APIPath.getGenbaWorkTime:
        return 'getGenbaWorkTime';
      case APIPath.worktimemonthdata:
        return 'worktimemonthdata';
      case APIPath.worktimesummary:
        return 'worktimesummary';
    }
  }
}
