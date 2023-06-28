enum StatusInventory {
  inStock('in stock'),
  outOfStock('out of stock'),
  lowStock('low stock');

  const StatusInventory(this.value);
  final String value;

  static StatusInventory getTypeByTitle(String title) {
    return StatusInventory.values.firstWhere((status) {
      return status.value == title;
    });
  }

  static String getValue(StatusInventory statusInventory) {
    return StatusInventory.values.firstWhere((status) {
      return status.name == statusInventory.name;
    }).value;
  }
}
