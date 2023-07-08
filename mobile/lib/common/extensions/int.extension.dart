extension XInt on int {
  int get toPositive => this < 0 ? this * -1 : this;
}
