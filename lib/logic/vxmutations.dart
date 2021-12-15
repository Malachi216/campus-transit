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

class SelectFromBustop extends VxMutation<TransitStore> {
  final String bank;

  SelectFromBustop(this.bank);

  @override
  perform() {
    store.selectedFromBustop = bank;
  }

  @override
  void onException(e, StackTrace s) {
    super.onException(e, s);
  }
}

class SelectToBustop extends VxMutation<TransitStore> {
  final String bank;

  SelectToBustop(this.bank);

  @override
  perform() {
    store.selectedToBustop = bank;
  }

  @override
  void onException(e, StackTrace s) {
    super.onException(e, s);
  }
}

class SelectTransitTime extends VxMutation<TransitStore> {
  final DateTime bank;

  SelectTransitTime(this.bank);

  @override
  perform() {
    store.selectedTransitTime = bank;
  }

  @override
  void onException(e, StackTrace s) {
    super.onException(e, s);
  }
}