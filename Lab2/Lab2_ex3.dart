// Ham thuong su dung if/else de kiem tra diem.
void checkScore(double score) {
  if (score >= 5) {
    print('Passed');
  } else {
    print('Failed');
  }
}

// Ham mui ten phu hop voi mot bieu thuc don gian.
int square(int number) => number * number;

void main() {
  double score = 7.5;
  checkScore(score);

  // Quy uoc ngay: 1 la Monday, 7 la Sunday.
  int day = 6;
  switch (day) {
    case 1:
      print('Monday');
      break;
    case 2:
      print('Tuesday');
      break;
    case 3:
      print('Wednesday');
      break;
    case 4:
      print('Thursday');
      break;
    case 5:
      print('Friday');
      break;
    case 6:
      print('Saturday');
      break;
    case 7:
      print('Sunday');
      break;
    default:
      print('Invalid day');
  }

  List<String> colors = ['Red', 'Green', 'Blue'];

  // for duyet qua chi so cua danh sach.
  for (int i = 0; i < colors.length; i++) {
    print('Color at index $i: ${colors[i]}');
  }

  // for-in lay truc tiep tung phan tu.
  for (String color in colors) {
    print('Color: $color');
  }

  // forEach goi ham cho moi phan tu.
  colors.forEach((color) {
    print('forEach color: $color');
  });

  print('Square of 4: ${square(4)}');
}