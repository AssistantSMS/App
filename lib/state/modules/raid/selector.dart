import 'package:scrapmechanic_kurtlourens_com/state/modules/base/appState.dart';

int getCarrot(AppState state) => state?.raidState?.carrot ?? 0;
int getTomato(AppState state) => state?.raidState?.tomato ?? 0;
int getBeetroot(AppState state) => state?.raidState?.beetroot ?? 0;
int getBanana(AppState state) => state?.raidState?.banana ?? 0;
int getBerry(AppState state) => state?.raidState?.berry ?? 0;
int getOrange(AppState state) => state?.raidState?.orange ?? 0;
int getPotato(AppState state) => state?.raidState?.potato ?? 0;
int getPineapple(AppState state) => state?.raidState?.pineapple ?? 0;
int getBroccoli(AppState state) => state?.raidState?.broccoli ?? 0;
int getCotton(AppState state) => state?.raidState?.cotton ?? 0;
