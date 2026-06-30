import '../data/repos/auth_repo.dart';
import '../presentation/cubits/auth_cubit.dart';

class SessionLogic {
  final AuthRepo _authRepo;

  SessionLogic(this._authRepo);

  Future<void> signOut(AuthCubit cubit) async {
    cubit.emitState(AuthLoadingState());
    await _authRepo.signOut();
    if (cubit.isClosed) return;
    cubit.emitState(SignOutSuccessState());
  }
}
