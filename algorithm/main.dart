void main() {
  List<int> numbers = [1, 3, 5, 7, 9];
  List<int> result = findMinMaxSum(numbers);
  print('${result[0]} ${result[1]}');
}

List<int> findMinMaxSum(List<int> arr) {
  int totalSum = arr.reduce((value, element) => value + element);
  int minSum = totalSum -
      arr.reduce((value, element) => value > element ? value : element);
  int maxSum = totalSum -
      arr.reduce((value, element) => value < element ? value : element);
  return [minSum, maxSum];
}
