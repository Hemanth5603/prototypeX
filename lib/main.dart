import 'package:flutter/material.dart'; 
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart'; 
import 'package:image_picker/image_picker.dart'; 

void main() { 
runApp(const MyApp()); 
} 

class MyApp extends StatefulWidget { 
const MyApp({super.key}); 

@override 
State<MyApp> createState() => _MyAppState(); 
} 

late String s=""; 

class _MyAppState extends State<MyApp> { 
final ImagePicker picker = ImagePicker(); 
@override 
Widget build(BuildContext context) { 
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
	return MaterialApp( 
    debugShowCheckedModeBanner: false,
	  home: SafeArea( 
		  child: Scaffold( 
		  backgroundColor: Color.fromARGB(255, 255, 255, 255), 
		  body: Column( 
		  children: [ 
      Container(
        width: w,
        height: h * 0.85,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(child: Text( s, style: TextStyle(color: Colors.black, fontSize: 20),))
      ),
			Container( 
        margin: EdgeInsets.all(8),
			  height: h * 0.08, 
			  width: w, 
			child: Center( 
				child: GestureDetector( 
					onTap: () async { 
					final XFile? image = 
						await picker.pickImage(source: ImageSource.gallery); 
					String a = await getImageTotext(image!.path); 
					setState(() { 
						s = a; 
					}); 
					}, 
					child: Container(
          margin:const EdgeInsets.all(10),
          width: w,
          height: h * 0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black
          ),
          child:Center(
            child: const Text("Upload Prescription",style: TextStyle(color: Colors.white,fontSize: 18),)
          ),
        ),
			), 
      ))
			
		  ], 
		), 
	)), 
	); 
} 
} 

Future getImageTotext(final imagePath) async { 
final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin); 
final RecognizedText recognizedText = 
	await textRecognizer.processImage(InputImage.fromFilePath(imagePath)); 
String text = recognizedText.text.toString(); 
return text; 
} 
