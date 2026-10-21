import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const AbayaAdenApp());
}

class AbayaAdenApp extends StatelessWidget {
  const AbayaAdenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'متجر عبايات عدن',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        fontFamily: 'Cairo',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      home: const HomeScreen(),
    );
  }
}

// ----------------- نماذج البيانات (Models) -----------------
class Abaya {
  final String id;
  final String title;
  final String category;
  final String fabric;
  final int priceYer;
  final int priceSar;
  final String image;
  final List<Color> colors;
  final List<String> colorNames;

  Abaya({
    required this.id,
    required this.title,
    required this.category,
    required this.fabric,
    required this.priceYer,
    required this.priceSar,
    required this.image,
    required this.colors,
    required this.colorNames,
  });
}

final List<Abaya> dummyProducts = [
  Abaya(
    id: '1',
    title: 'عباية صالونا ملكي كلاسيك',
    category: 'black',
    fabric: 'كريب صالونا ياباني أصلي',
    priceYer: 38000,
    priceSar: 72,
    image: 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=600&q=80',
    colors: [Colors.black, const Color(0xFF1C1C1C)],
    colorNames: ['أسود فاحم', 'أسود كربوني'],
  ),
  Abaya(
    id: '2',
    title: 'عباية كريب انترنت تطريز هادئ',
    category: 'black',
    fabric: 'إنترنت كوري درجة أولى',
    priceYer: 42000,
    priceSar: 80,
    image: 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=600&q=80',
    colors: [Colors.black],
    colorNames: ['أسود ملكي'],
  ),
  Abaya(
    id: '3',
    title: 'عباية لينن صيفية راقية',
    category: 'colored',
    fabric: 'لينن بارد مع حرير مغسول',
    priceYer: 45000,
    priceSar: 85,
    image: 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=600&q=80',
    colors: [const Color(0xFF2E4034), const Color(0xFF334257), const Color(0xFFB88E8D), const Color(0xFFCBB279)],
    colorNames: ['زيتي', 'كحلي ليلي', 'كشميري', 'بيج صحراوي'],
  ),
  Abaya(
    id: '4',
    title: 'عباية دبل فيس لونين',
    category: 'colored',
    fabric: 'كريب ندى ملكي',
    priceYer: 48000,
    priceSar: 90,
    image: 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=600&q=80',
    colors: [const Color(0xFF533E2D), const Color(0xFF6B728E)],
    colorNames: ['شوكولاتة', 'رمادي مزرق'],
  ),
];

// ----------------- الشاشة الرئيسية (Home) -----------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'black';

  @override
  Widget build(BuildContext context) {
    final filteredList = dummyProducts.where((p) => p.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('متجر العبايات الفاخرة'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            color: const Color(0xFFF3E5AB),
            child: const Text(
              '📍 خدمة الاستلام متوفرة حصرياً داخل محافظة عدن (الحجاز - صيدلية الثقافة - الحاشدي)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('عبايات سوداء 🖤', style: TextStyle(fontWeight: FontWeight.bold))),
                    selected: selectedCategory == 'black',
                    selectedColor: Colors.black,
                    labelStyle: TextStyle(color: selectedCategory == 'black' ? Colors.white : Colors.black),
                    onSelected: (val) => setState(() => selectedCategory = 'black'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('عبايات ملونة 🌸', style: TextStyle(fontWeight: FontWeight.bold))),
                    selected: selectedCategory == 'colored',
                    selectedColor: Colors.black,
                    labelStyle: TextStyle(color: selectedCategory == 'colored' ? Colors.white : Colors.black),
                    onSelected: (val) => setState(() => selectedCategory = 'colored'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final item = filteredList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ProductDetailScreen(abaya: item)),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(Icons.checkroom, size: 60, color: Colors.black54),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(height: 4),
                              Text(item.fabric, maxLines: 1, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                              const SizedBox(height: 6),
                              Text('${item.priceYer} ريال', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                              Text('(${item.priceSar} ر.س)', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------- شاشة تفاصيل العباية والتفصيل (Product Details) -----------------
class ProductDetailScreen extends StatefulWidget {
  final Abaya abaya;
  const ProductDetailScreen({Key? key, required this.abaya}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedColorIndex = 0;
  String selectedClosure = 'طقطق كامل';
  final lengthController = TextEditingController(text: '54');
  final widthController = TextEditingController(text: '23');
  final notesController = TextEditingController();

  final List<String> closures = ['طقطق كامل', 'طقطق نص للصدر', 'لف بدون طقطق', 'سحاب مخفي'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.abaya.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.checkroom, size: 80, color: Colors.black45),
            ),
            const SizedBox(height: 16),
            Text(widget.abaya.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('نوع القماش: ${widget.abaya.fabric}', style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 8),
            Text('${widget.abaya.priceYer} ريال يمني (${widget.abaya.priceSar} ر.س)',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.brown)),

            const Divider(height: 30),
            Text('اللون المختار: ${widget.abaya.colorNames[selectedColorIndex]}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.abaya.colors.length,
                itemBuilder: (context, idx) {
                  return GestureDetector(
                    onTap: () => setState(() => selectedColorIndex = idx),
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedColorIndex == idx ? Colors.black : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(backgroundColor: widget.abaya.colors[idx], radius: 18),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 30),
            const Text('مقاسات التفصيل المطلوبة (بالإنش):', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: lengthController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'الطول بالإنش',
                      suffixText: 'إنش',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: widthController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'العرض (الصدر)',
                      suffixText: 'إنش',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('قفلة العباية:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Wrap(
              spacing: 8,
              children: closures.map((cl) {
                return ChoiceChip(
                  label: Text(cl),
                  selected: selectedClosure == cl,
                  selectedColor: Colors.black,
                  labelStyle: TextStyle(color: selectedClosure == cl ? Colors.white : Colors.black),
                  onSelected: (val) => setState(() => selectedClosure = cl),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              decoration: InputDecoration(
                labelText: 'ملاحظات إضافية (تعديل كم، قماش طرحة...)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutScreen(
                      abaya: widget.abaya,
                      selectedColor: widget.abaya.colorNames[selectedColorIndex],
                      length: lengthController.text,
                      width: widthController.text,
                      closure: selectedClosure,
                      notes: notesController.text,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('متابعة لاختيار نقطة الاستلام والدفع', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------- شاشة إتمام الطلب والدفع (Checkout Screen) -----------------
class CheckoutScreen extends StatefulWidget {
  final Abaya abaya;
  final String selectedColor;
  final String length;
  final String width;
  final String closure;
  final String notes;

  const CheckoutScreen({
    Key? key,
    required this.abaya,
    required this.selectedColor,
    required this.length,
    required this.width,
    required this.closure,
    required this.notes,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final List<Map<String, String>> pickupHubs = [
    {
      'title': 'الشيخ عثمان - الحجاز مول',
      'hours': 'ساعات التواجد: من 4:00 عصراً إلى 11:00 مساءً',
    },
    {
      'title': 'خور مكسر - صيدلية الثقافة',
      'hours': 'ساعات التواجد: من 8:00 صباحاً إلى 12:00 منتصف الليل',
    },
    {
      'title': 'كريتر - سوق الحاشدي',
      'hours': 'ساعات التواجد: صباحاً ومساءً (أوقات السوق)',
    },
  ];

  String? selectedHub;
  String selectedBank = 'qutaibi';
  final refNumberController = TextEditingController();
  final customerNameController = TextEditingController();
  final customerPhoneController = TextEditingController();
  bool isReceiptAttached = false;

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم نسخ الرقم: $text')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نقطة الاستلام والدفع')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('بياناتكِ للتواصل:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: customerNameController,
              decoration: const InputDecoration(labelText: 'الاسم الكامل', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: customerPhoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'رقم هاتف / واتساب', border: OutlineInputBorder()),
            ),

            const Divider(height: 30),
            const Text('اختاري مكان استلام العباية في عدن:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...pickupHubs.map((hub) {
              return Card(
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: RadioListTile<String>(
                  title: Text(hub['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(hub['hours']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  value: hub['title']!,
                  groupValue: selectedHub,
                  activeColor: Colors.black,
                  onChanged: (val) => setState(() => selectedHub = val),
                ),
              );
            }).toList(),

            const Divider(height: 30),
            const Text('الدفع تحويل / إيداع عبر بنوك عدن:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Card(
              color: selectedBank == 'qutaibi' ? const Color(0xFFF1F8E9) :
              
