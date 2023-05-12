// used to remove everything like +, (), spaces etc & only keep the number
import 'modals/my_contact_modal.dart';

RegExp numberRegEx = RegExp(r"\D+");

List<MyContact> allContacts = [];
