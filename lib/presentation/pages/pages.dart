//import 'dart:html';

// import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:getseat/core/utils/utils.dart';
import 'package:getseat/data/models/models.dart';
import 'package:getseat/domain/local/db/db_repository.dart';
import 'package:getseat/domain/repositories/repository.dart';
import 'package:getseat/presentation/bloc/blocs.dart';
import 'package:getseat/presentation/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

part 'account_confirmation_page.dart';
part 'checkout_page.dart';
part 'home_page.dart';
part 'main_page.dart';
part 'movie_detail_page.dart';
part 'movie_page.dart';
part 'preference_page.dart';
part 'profile_page.dart';
part 'select_schedule_page.dart';
part 'select_seat_page.dart';
part 'sign_in_page.dart';
part 'sign_up_page.dart';
part 'splash_page.dart';
part 'wrapper.dart';