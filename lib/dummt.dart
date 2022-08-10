import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

List<Map<String, String>> servicesList = [
  {"image": "assets/images/cleaning.png", "name": "Cleaning"},
  {"image": "assets/images/car_wash.png", "name": "Car Wash"},
  {"image": "assets/images/haircut.png", "name": "Hair for Him"},
  {"image": "assets/images/haircut.png", "name": "Hair for Her"},
  {"image": "assets/images/massage.png", "name": "Spa for Him"},
  {"image": "assets/images/massage.png", "name": "Spa for her"},
  {"image": "assets/images/cooking.jpg", "name": "Cooking"},
  //{"image": "assets/images/cleaning.png", "name": "Cleaning"},
];

//   void printPdf() async {
//     http.Response response = await http
//         .get(Uri.parse('http://www.africau.edu/images/default/sample.pdf'));
//     var pdfData = response.bodyBytes;
//     await Printing.layoutPdf(onLayout: (format) async => pdfData);
//   }

//   void sharePdf() async {
//     http.Response response = await http
//         .get(Uri.parse('http://www.africau.edu/images/default/sample.pdf'));
//     var pdfData = response.bodyBytes;
//     await Printing.sharePdf(bytes: pdfData, filename: 'anyname.pdf');
//     //file name mai koi bhi name de dena but end it with .pdf
//   }

//   bool downloading = false;
//   var progressString = "";

//   Future<void> downloadFile() async {
//     Dio dio = Dio();

//     try {
//       var dir = await getApplicationDocumentsDirectory();
//       print("path ${dir.path}");
//       await dio.download(
//           "https://www.clickdimensions.com/links/TestPDFfile.pdf",
//           "${dir.path}/demo.mp4", onReceiveProgress: (rec, total) {
//         print("Rec: $rec , Total: $total");

//         setState(() {
//           downloading = true;
//           progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
//         });
//       });
//     } catch (e) {
//       print(e);
//     }

//     setState(() {
//       downloading = false;
//       progressString = "Completed";
//     });
//     print("Download completed");
//   }

void printPdf() async {
  // http.Response response = await http.get(Uri.parse(
  //     'https://swayamkiosk.s3.amazonaws.com/nehavijayjaiswal882022120810pm.pdf'));
  // var pdfData = response.bodyBytes;
  // await Printing.layoutPdf(onLayout: (format) async => pdfData);
}

// void sharePdf() async {
//   http.Response response = await http
//       .get(Uri.parse('http://www.africau.edu/images/default/sample.pdf'));
//   var pdfData = response.bodyBytes;
//   await Printing.sharePdf(bytes: pdfData, filename: 'anyname.pdf');
// }

// void downloadPdf() async {
//   http.Response response = await http
//       .get(Uri.parse('http://www.africau.edu/images/default/sample.pdf'));
//   var pdfData = response.bodyBytes;

//   final output = await getApplicationDocumentsDirectory();
//   final file = File('${output.path}/anyname.pdf');
//   await file.writeAsBytes(pdfData);
//   await OpenFile.open(file.path);
// }
String htmlll = """
<html>
<head><link rel="stylesheet" href="invoice.css"></head>
<body style="padding: 3rem">
    <h1>Invoice</h1>
    Awesome company<br />
    7026 Hunters Creek Dr<br />

    <h2 style="margin-top: 3rem">Bill to</h2>
    {{ invoice.customer.name | html.escape }}<br />
    {{ invoice.customer.address | html.escape }}<br />

    <div style="margin-top: 3rem">
        Invoice No: #{{ invoice.id }}<br />
        Date: #{{ invoice.created_at }}
    </div>


</body>
</html>
""";
