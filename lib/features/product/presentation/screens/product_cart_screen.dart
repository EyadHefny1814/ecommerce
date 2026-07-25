import 'package:flutter/material.dart';
import 'product_screen.dart';

class ProductCartScreen extends StatefulWidget {
  final List<CartItem> cart;
  final VoidCallback onCartUpdated;

  const ProductCartScreen({
    super.key,
    required this.cart,
    required this.onCartUpdated,
  });

  @override
  State<ProductCartScreen> createState() => _ProductCartScreenState();
}

class _ProductCartScreenState extends State<ProductCartScreen> {
  double get _cartSubtotal {
    double total = 0.0;
    for (var item in widget.cart) {
      total += item.price * item.qty;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('My Cart', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                Text('Edit', style: TextStyle(color: Color(0xFFFF3B00), fontSize: 15, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          widget.cart.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Center(child: Text('Your cart is empty.', style: TextStyle(color: Colors.grey))),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.cart.length,
                  itemBuilder: (context, index) {
                    final item = widget.cart[index];
                    return _buildCartItemCard(item, index);
                  },
                ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF141414),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 14)),
                    Text('\$${_cartSubtotal.toStringAsFixed(0)}.00', style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Shipping', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 14)),
                    Text('\$0.00', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(color: Colors.white10),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                    Text('\$${_cartSubtotal.toStringAsFixed(0)}.00', style: const TextStyle(color: Color(0xFFFF3B00), fontWeight: FontWeight.bold, fontSize: 15)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF3B00),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('PROCEED TO CHECKOUT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemCard(CartItem item, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFF090909),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Image.network(item.img, fit: BoxFit.contain),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: SizedBox(
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white), maxLines: 1),
                      if (item.sub.isNotEmpty) Text(item.sub, style: const TextStyle(fontSize: 11, color: Color(0xFF8E8E93))),
                      Text(item.meta, style: const TextStyle(fontSize: 11, color: Color(0xFF8E8E93))),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (item.qty > 1) {
                              setState(() => item.qty--);
                              widget.onCartUpdated();
                            }
                          },
                          child: const Text('-', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text('${item.qty}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() => item.qty++);
                            widget.onCartUpdated();
                          },
                          child: const Text('+', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() => widget.cart.removeAt(index));
                    widget.onCartUpdated();
                  },
                  child: const Icon(Icons.close, color: Color(0xFF888888), size: 16),
                ),
                Text('\$${(item.price * item.qty).toStringAsFixed(0)}.00', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
