part of playhunt.common;

/// The [HuntService] handles communication with repository related
/// methods of the PlayHunt API.
///
class HuntService extends Service {
  HuntService(PlayHunt playhunt) : super(playhunt);

  /// List the hunt
  Stream<List<Hunt>>  listHunts() {

    return new PaginationHelper(_playhunt).objects(
        "GET", "/hunt", Hunt.fromJSON);
  }

  ///Create an Hunt
  Future<Hunt> createHunt(Hunt hunt) {
      return _playhunt.postJSON('/admin/hunt',
      body: hunt.toJSON(), convert: Hunt.fromJSON);
  }


}
