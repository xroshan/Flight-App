import 'package:scoped_model/scoped_model.dart';

import './all_model.dart';

class MainModel extends Model with AllModel, AirportModel, UserModel {}
