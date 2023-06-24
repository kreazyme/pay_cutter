final RegExp checkBill = RegExp(
  r'tong thanh toan|tong tien|tong cong|tong tien hang|t\.cong',
  multiLine: true,
  caseSensitive: false,
);

final RegExp recheckBill = RegExp(
  r'thanh tien|tong',
);

final RegExp isMoney = RegExp(
  r'\b(\d*[0]0)(?!\d)',
  multiLine: true,
);
