import 'package:campus_transit/logic/vxstore.dart';
import 'package:velocity_x/velocity_x.dart';

class UpdateLoadingStatus extends VxMutation<TransitStore> {
  final bool isLoading;
  UpdateLoadingStatus(this.isLoading);

  @override
  void perform() async {
    store.isLoading = isLoading;
  }

  @override
  void onException(e, StackTrace s) {
    super.onException(e, s);
  }
}
