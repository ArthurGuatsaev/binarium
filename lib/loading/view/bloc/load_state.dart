// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'load_bloc.dart';

class LoadState {
  final List<VLoading> loadingList;
  final StatusLoadState status;
  final VFailed failed;
  LoadState({
    this.loadingList = const [],
    this.failed = const VFailed(message: ''),
    this.status = StatusLoadState.initial,
  });

  LoadState copyWith({
    List<VLoading>? loadingList,
    StatusLoadState? status,
    VFailed? failed,
  }) {
    return LoadState(
        loadingList: loadingList ?? this.loadingList,
        status: status ?? this.status,
        failed: failed ?? this.failed);
  }
}

enum StatusLoadState { initial, loading, success, failed }
