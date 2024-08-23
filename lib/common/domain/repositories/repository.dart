abstract class IRepository<R, P> {
  Future<R> execute({required P param});
}
