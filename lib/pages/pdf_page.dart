import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import '../model/data_model.dart';

class PdfPage extends StatefulWidget {
  List<DataModel> data = [];

  String? scno;
  String? NameandAddress;
  String? Date;
  String? Sload;
  String? Rload;
  String? Mcap;
  String? Reason;
  String? inspectionDate;
  String? recommendendation;
  String? RegDetails;
  String? Hscno;
  String? Applicationdetails;
  String? Madequate;
  String? Mdetails;
  String? Slnorow;
  String? tf;

  @override
  State<PdfPage> createState() => _PdfPageState();

  PdfPage(
      {required this.data,
      this.scno,
      this.NameandAddress,
      this.Date,
      this.Sload,
      this.Rload,
      this.Mcap,
      this.Reason,
      this.inspectionDate,
      this.recommendendation,
      this.RegDetails,
      this.Hscno,
      this.Applicationdetails,
      this.Madequate,
      this.Mdetails,
      this.Slnorow,
      this.tf});
}

class _PdfPageState extends State<PdfPage> {
  PrintingInfo? printingInfo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final info = await Printing.info();

    setState(() {
      printingInfo = info;
    });
  }

  String addSpaces(String text, int space) {
    return text.padLeft(text.length + space);
  }

  String singleLineTextfromMultiline(String text) {
    return text.replaceAll('\n', '');
  }

  Widget build(BuildContext context) {
    bool status;
    int Bload = 0;

    DateTime _date = DateTime.now();
    setState(() {
      widget.Sload == '' || widget.Rload == '' ? status = false : status = true;
      status == true
          ? Bload = int.parse(widget.Sload.toString()) -
              int.parse(widget.Rload.toString())
          : Bload = 0;
    });

    Future<Uint8List> generatedPdf(final PdfPageFormat format) async {
      final doc = pw.Document(
        title: 'Load Reduction',
      );
      header(context) => pw.Header(
            level: 2,
            child: pw.Text(
                'FORMAT FOR REDUCTION OF LOAD TO EX.SC.NO.${widget.Hscno} IN RESPECT OF AE/ ROCKFORT / DINDIGUL SECTION OF AEE / WEST / DINDIGUL SUB DIVISION.',
                textAlign: pw.TextAlign.center,
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)),
            // textStyle:
            //     pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)
          );
      final pageTheme = await _myPageTheme(format);

      doc.addPage(pw.MultiPage(
        pageTheme: pageTheme,
        header: header,
        build: (final context) => [
          pw.Container(
            padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Divider(),
                mainRow('1. SC.NO. and Distribution', widget.scno),
                mainRow(
                    '2. Name and Address  of the Party', widget.NameandAddress),
                mainRow('3. Tariff and Date of SC', widget.Date),
                mainRow('4. Sanctioned Load', '${widget.Sload} KW'),
                mainRow(
                    '5. Reduction of Load Now Required', '${widget.Rload} KW'),
                mainRow('6.  Balance Load using', '${Bload.toString()} KW'),
                mainRow('7.  Meter capacity', widget.Mcap),
                mainRow('9.  Meter Adequate & Type of Work involved',
                    widget.Madequate),
                mainRow('10.  Reason for  Reduction', widget.Reason),
                mainRow('11.  Date of Inspection', widget.inspectionDate),
                mainRow('12. Recommendation', widget.recommendendation),
                pw.SizedBox(
                  width: 600,
                  child: pw.Text(
                      textAlign: pw.TextAlign.left,
                      '13. At the time of Inspection the following load are found :'),
                ),
                pw.SizedBox(height: 5),
                buildDataTable(),
                buildTotal(widget.data),
                pw.SizedBox(height: 5),
                pw.Table(
                  //border: pw.TableBorder.all(),
                  border: null,
                  columnWidths: {
                    0: const pw.FlexColumnWidth(2),
                    1: const pw.FlexColumnWidth(1),
                  },
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Text('Application Details',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text('Collection Details',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Text('${widget.RegDetails}'),
                        pw.Text('${widget.Applicationdetails}'),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Table(
                  //border: pw.TableBorder.all(),
                  border: null,
                  columnWidths: {
                    0: const pw.FlexColumnWidth(2),
                    1: const pw.FlexColumnWidth(1),
                  },
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Text('Meter Details',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text('Reading Details',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Text('${widget.Mdetails}'),
                        pw.Text('${widget.Slnorow}'),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                    'Hence I request that the proposal may kindly be sanctioned early please.'),
              ],
            ),
          ),
        ],
      ));

      Tangedcoheader(context) => pw.Header(
          level: 2,
          child: pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text('TANGEDCO',
                textAlign: pw.TextAlign.center,
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)),
          ));

// Covering Letter
      doc.addPage(pw.MultiPage(
          pageTheme: pageTheme,
          header: Tangedcoheader,
          build: (final context) => [
                pw.Container(
                  padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Table(
                          //border: pw.TableBorder.all(),
                          border: null,
                          columnWidths: {
                            0: const pw.FlexColumnWidth(1),
                            1: const pw.FlexColumnWidth(1),
                          },
                          children: [
                            pw.TableRow(
                              children: [
                                pw.Text(
                                  'From',
                                ),
                                pw.Text(
                                  'To',
                                ),
                              ],
                            ),
                            pw.TableRow(
                              children: [
                                pw.Text(
                                    'Assistant Engineer,\nOperation & Maintenance,\nRockfort\nDindigul.'),
                                pw.Text(
                                    'Assistant Executive Engineer,\nWest Sub Division,\nDindigul.'),
                              ],
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.SizedBox(
                          child: pw.Text(
                            'Lr.No.AE/RFT/DGL/CA/F.RL/PRO.No.    /${_date.year}, Dt.   .${_date.month}/${_date.year}',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                        pw.SizedBox(
                          child: pw.Text(
                            'Sir',
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 20),
                          child: pw.Table(
                            //border: pw.TableBorder.all(),
                            border: null,
                            columnWidths: {
                              0: const pw.FlexColumnWidth(1),
                              1: const pw.FlexColumnWidth(10),
                            },

                            children: [
                              pw.TableRow(
                                children: [
                                  pw.Text(
                                    'Sub:',
                                  ),
                                  pw.Text(
                                    'Elecy - Reduction of Load - Ex.Sc.No. ${widget.Hscno} under TF ${widget.tf} - Approval requested   Proposal - Submission of  Regarding.',
                                    textAlign: pw.TextAlign.justify,
                                  ),
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text('Ref:'),
                                  pw.Text('Party  ${widget.RegDetails}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                            // '          I am submit herewith the Proposal for Reduction of Load  to Ex.Sc.No. 207-002-606 under Tariff V as per the Party request by D.Karthik, S/O Dhandapani, D.NO.42,Palani Road, Dindigul.  under the jurisdiction of Assistant Engineer / 0&M / Rockfort / Dindigul section for favour of further action and early approval accorded Please.',
                            addSpaces(
                                'I am submitting herewith the Proposal for Reduction of Load  to Ex.Sc.No. ${widget.Hscno} under TF ${widget.tf} as per the Party request by ${singleLineTextfromMultiline(widget.NameandAddress.toString())} under the jurisdiction of Assistant Engineer / O&M / Rockfort / Dindigul section for favour of further action and early approval accorded Please.',
                                6),
                            textAlign: pw.TextAlign.justify,
                            style: pw.TextStyle(height: 2.0)),
                        pw.SizedBox(height: 40),
                        pw.Table(
                          //border: pw.TableBorder.all(),
                          border: null,
                          columnWidths: {
                            0: const pw.FlexColumnWidth(1),
                            1: const pw.FlexColumnWidth(1),
                          },
                          children: [
                            pw.TableRow(
                              children: [
                                pw.Text(''),
                                pw.Text(
                                    'Assistant Engineer,\nOperation & Maintenance,\nRockfort\nDindigul.'),
                              ],
                            ),
                          ],
                        ),
                        pw.Text(
                            'Encl:	Format - 2 Nos.\n ${addSpaces('Application- 1 No', 8)}'),
                      ]),
                )
              ]));

      return doc.save();
    }

    pw.RichText.debug = true;
    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        const PdfPreviewAction(icon: Icon(Icons.save), onPressed: SaveasFile)
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Load Reduction'),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Expanded(
            child: PdfPreview(
              maxPageWidth: 700,
              actions: actions,
              onPrinted: showPrintedToast,
              onShared: showSharedToast,
              build: generatedPdf,
            ),
          ),
        ],
      ),
    );
  }

  buildDataTable() {
    final headers = ['Description', 'Qty', 'Watts', 'Total'];

    final data = widget.data.map((item) {
      return [item.description, item.qty, item.watt, item.total];
    }).toList();

    return pw.Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
      cellHeight: 15,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
      },
    );
  }
}

buildTotal(data) {
  // final netTotal = data.tableitems
  //     .map((item) => item.watt * item.qty)
  //     .reduce((item1, item2) => item1 + item2);
  //
  // final total = netTotal;
  final dataTotal =
      data.map((item) => item.total).reduce((item1, item2) => item1 + item2);
  return pw.Container(
    // pw.alignment: pw.Alignment.centerRight,
    child: pw.Row(
      children: [
        pw.Spacer(flex: 6),
        pw.Expanded(
          flex: 4,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Divider(),
              buildText(
                title: 'Total',
                value: Utils.formatCell(dataTotal.toDouble()),
                unite: true,
              ),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              pw.Container(height: 1, color: PdfColors.grey400),
              pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
              pw.Container(height: 1, color: PdfColors.grey400),
            ],
          ),
        ),
      ],
    ),
  );
}

// final _header =
//     'FORMAT FOR REDUCTION OF LOAD TO EX.SC.NO. IN RESPECT OF AE/ ROCKFORT / DINDIGUL SECTION OF AEE / WEST / DINDIGUL SUB DIVISION.';

// pw.Widget pdf_header(final context) =>
//     pw.Text('$_header', textAlign: pw.TextAlign.center);

pw.Column mainRow(final header, final content) {
  return pw.Column(
    children: [
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 250,
            child: pw.Text(
              textAlign: pw.TextAlign.left,
              '$header',
              style: const pw.TextStyle(fontSize: 12),
            ),
          ),
          pw.SizedBox(
            width: 25,
            child: pw.Text(
              textAlign: pw.TextAlign.left,
              ':',
              style: const pw.TextStyle(fontSize: 12),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              textAlign: pw.TextAlign.left,
              '$content',
              style: const pw.TextStyle(fontSize: 12),
            ),
          ),
          pw.SizedBox(height: 20),
        ],
      ),
      pw.SizedBox(height: 4),
    ],
  );
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  // final logoImage = pw.MemoryImage(
  //     (await rootBundle.load('assets/pdf.png')).buffer.asUint8List());
  return pw.PageTheme(
    margin: const pw.EdgeInsets.symmetric(
      horizontal: 1 * PdfPageFormat.cm,
      vertical: 0.5 * PdfPageFormat.cm,
    ),
    textDirection: pw.TextDirection.ltr,
    orientation: pw.PageOrientation.portrait,
    buildBackground: (final context) => pw.FullPage(
      ignoreMargins: true,
      child: pw.Text(''),
    ),
  );
}

Future<void> SaveasFile(
  final BuildContext context,
  final LayoutCallback build,
  final PdfPageFormat pageFormat,
) async {
  final bytes = await build(pageFormat);
  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File('$appDocPath/documet.pdf');
  //print('Save as file ${file.path}...');
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);
}

void showPrintedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document Printed Successfully')));
}

void showSharedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document Shared Successfully')));
}

buildText({
  required String title,
  required String value,
  double width = double.infinity,
  TextStyle? titleStyle,
  bool unite = false,
}) {
  final mystyle = pw.TextStyle(fontWeight: pw.FontWeight.bold);

  return pw.Container(
    width: width,
    child: pw.Row(
      children: [
        pw.Expanded(
          child: pw.Text(title, style: unite ? null : mystyle),
        ),
        pw.Text(value, style: mystyle),
      ],
    ),
  );
}

class Utils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatCell(double load) => ' ${load.toStringAsFixed(0)} W';
}
