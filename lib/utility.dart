library utility;
 export 'package:get/get.dart';
 export 'package:utility/shared_pref_service/SharedService.dart';
 export 'package:utility/widgets/txt_field.dart';
export 'package:utility/widgets/txt_date-field.dart';

import 'package:flutter/cupertino.dart';
import 'package:utility/shared_pref_service/SharedService.dart';


class Utility extends StatefulWidget {
  const Utility({super.key});

  @override
  State<Utility> createState() => _UtilityState();
}

class _UtilityState extends State<Utility> {
  var prefs=SharedService();
  @override
  void initState() {
     super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
 var s= SharedService();
}
