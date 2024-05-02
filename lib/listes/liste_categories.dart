final Map<String, String> categoryToProfession = {
  'Aluminum works': 'Aluminum',
  'Paints and decorations': 'Painter',
  'Plumbing works': 'Plumber',
  'Air conditioner repairs': 'Air Conditioner Technician',
  'Carpentry works': 'Carpenter',
  'Household appliances repairs': 'Appliance Repair Technician',
  'Electrical works': 'Electrician',
  'Cleaning services and maintenance': 'Cleaner',
};

final List<String> categories = [
  'Aluminum works',
  'Paints and decorations',
  'Plumbing works',
  'Air conditioner repairs',
  'Carpentry works',
  'Household appliances repairs',
  'Electrical works',
  'Cleaning services and maintenance',
];

// قم بتحويل الفئة إلى مهنة الحرفي قبل استخدامها في الواجهة
String getProfessionForCategory(String category) {
  return categoryToProfession[category] ?? category;
}
