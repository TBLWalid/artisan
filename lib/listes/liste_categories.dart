final Map<String, String> categoryToProfession = {
  'Aluminum works': 'Aluminum',
  'Paints and decorations': 'Painter',
  'Plumbing works': 'Plumber',
  'Air conditioner repairs': 'Air Conditioner Technician',
  'Carpentry works': 'Carpenter',
  'Household appliances repairs': 'Appliance Repair Technician',
  'Electrical works': 'Electrician',
  'Cleaning services and maintenance': 'Cleaner',
  'Landscaping and gardening': 'Landscaper',
  'Roofing services': 'Roofing Contractor',
  'Pest control services': 'Pest Control Technician',
  'Flooring services': 'Flooring Installer',
  'Glass and mirror services': 'Glazier',
  'Security systems installation': 'Security Systems Installer',
  'Furniture assembly services': 'Furniture Assembler',
  'Moving and relocation services': 'Mover',
  'Carpet cleaning services': 'Carpet Cleaner',
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
  'Landscaping and gardening',
  'Roofing services',
  'Pest control services',
  'Flooring services',
  'Glass and mirror services',
  'Security systems installation',
  'Furniture assembly services',
  'Moving and relocation services',
  'Carpet cleaning services',
];

// قم بتحويل الفئة إلى مهنة الحرفي قبل استخدامها في الواجهة
String getProfessionForCategory(String category) {
  return categoryToProfession[category] ?? category;
}
