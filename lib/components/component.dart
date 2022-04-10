import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:football_scores_api/components/style.dart';


Widget defaultTextField({
required  textInputType,
 required String label,
 bool obscureText = false,
 controller,
 Widget?  prefixIcon,
 Widget?  prefix,
 Widget?  suffixIcon,
 Widget?  suffix,
   validator,
  maxLength = 80,
  onEditingComplete,
  floatingLabelBehavior,
  double borderRadius = 30,

})=>  Padding(
  padding: const EdgeInsets.all(8.0),
  child:   TextFormField(
  maxLength:maxLength ,
    controller: controller,
    obscureText: obscureText,
    keyboardType: textInputType,
    validator:validator ,
    decoration: InputDecoration(
      floatingLabelBehavior:floatingLabelBehavior ,
     counterText: '',
      prefixIcon: prefixIcon,
      prefix:prefix ,
      suffixIcon:suffixIcon ,
      contentPadding: EdgeInsets.symmetric(horizontal: 30),
      suffix:suffix ,
      fillColor:Color(0xff2B282E),
      filled: true,
      labelText: label,
      labelStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),

      ),
    ),
  ),
);

Widget defaultTextMessageField({
  controller,
  label,
})=> TextFormField(
  controller: controller,
  maxLines: null,
  maxLength: 5000,
  decoration: InputDecoration(
    counterText: '',
      contentPadding: EdgeInsets.symmetric(horizontal: 30),
      fillColor:Color(0xff2B282E),
      filled: true,
      label :label ,
      labelStyle: const TextStyle(color:Colors.white),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),

      ),
      floatingLabelBehavior: FloatingLabelBehavior.never
  ),
);



Widget defaultElevatedButton({
  backgroundColor  =const Color(0xff2B282E),
  required String label,
  required  onPressed
})=> ElevatedButton(
    onPressed: onPressed,
    style: ButtonStyle(
      padding:MaterialStateProperty.all( EdgeInsets.symmetric(horizontal: 50,),),
      fixedSize:MaterialStateProperty.all(
        Size.fromWidth(double.infinity),

      ) ,
      shape:MaterialStateProperty.all(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
          )
      ) ,
      backgroundColor: MaterialStateProperty.all(backgroundColor),
    ),
    child: Text(label.toUpperCase(),
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: "bolt-semibold",
      ),),


    );


Widget defaultTextButton({
  required String label,
  required  onPressed,
  double?  size,
  Color  color = Colors.blueAccent ,
})=>TextButton(
    onPressed: onPressed,
    child: Text(label,
       style:TextStyle(
         fontSize: size,
          color:color) ,
));
enum ToastStates {success,warning,error}

Color? toastColors(ToastStates state ){
  Color color;
  switch (state){
    case ToastStates.success:
      color = const Color(0xff076848);
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.yellow;
      break;
    }
    return color;

  }

defaultToastMessage({
  required msg ,
  required ToastStates state,
}){
  Fluttertoast.showToast(msg: msg,backgroundColor: toastColors(state),fontSize: 17,timeInSecForIosWeb: 2);
}


//  Future defaultCheckInternet()async{
//   var connectivityResult = await Connectivity().checkConnectivity();
//       if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
//         defaultToastMessage(msg: "Check The Internet Connection", color: Colors.red);
//         return;
//       }
// }

 defaultShowDialog({
    required context,
    required String text,
})=> showDialog(
   barrierDismissible: true,
  context: context,
    builder: (context)=> Dialog(
      child: Container(color: kBackgroundColor,
        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 35),
        child: Row(
          children: [
          CircularProgressIndicator(),
            SizedBox(width: 25,),
            Text(text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            ),
        ],),
      ),
    ) ,

);

 navigateByTimer({required context, int seconds = 1}){

   Future.delayed(
       Duration(seconds:seconds ),(){
     Navigator.pop(context);
   });
}

defaultFutureDelayed({seconds, function}){
  Future.delayed(
      Duration(seconds:seconds ),function);

}

Widget defaultDivider({
  color = Colors.grey,
})=>Divider(
  height: 2,
  color:color,
  thickness: .7,
);

  navigateTo({
    required route,
       required  context})
  =>  Navigator.push(
         context,
         MaterialPageRoute(
             builder: (context)=>
              route));



navigateAndRemoveTo({
  required route,
  required  context
})
=>  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=> route), (route) => false);
