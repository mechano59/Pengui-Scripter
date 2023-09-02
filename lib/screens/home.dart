import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  String _savedText = '';
  String customVariable = '';
  String customArgument = '';
  String ifArgument = '';
  String ifThenArgument = '';
  String? dropdownNames;

  // Map of options for the second dropdown based on the selected option of the first dropdown
  final Map<String, List<String>> secondDropdownOptions = {
    'Add': ['echo','cd','ls','cp','mv','rm','mkdir','rmdir','cat','chmod','clear','pwd','wget','which','whoami','chown','read'],

    'If': ['User Input','Argument'],
    
    'If Not': ['User Input','Argument'],
  };
  String? dropdownSecondValue;
  String? dropdownThirdValue;

  // Create a new file and clear the text
  void createNewFile() {
    _textEditingController.clear();
  }

  // Function to insert custom text at the end of the text
  void insertCustomText(String customText) {
    final String currentText = _textEditingController.text;
    final String newText = currentText + customText;
    _textEditingController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String>? secondDropdownItems = secondDropdownOptions[dropdownNames ?? ''];
    return Scaffold(
      appBar: AppBar(
        title: Text('PenGUI Scripter'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right:25.0),
                child: ElevatedButton(
                  onPressed: () {
                    createNewFile();
                  },
                  child: Text('New File'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:25.0),
                child: ElevatedButton(
                  onPressed: _showAlertDialog,
                  child: Text('Save'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DropdownButton<String>(
                value: dropdownNames,
                underline: SizedBox(
                  height: 0,
                ),
                hint: Container(
                    padding: EdgeInsets.only(left: 1),
                    child: Text(
                      'Choose Action',
                      style: TextStyle(fontSize: 16),
                    )),
                icon: Container(
                    padding: EdgeInsets.only(left: 1),
                    child: Icon(
                      Icons.arrow_drop_down,
                    )),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownNames = newValue;
                    // Reset the second dropdown value when the first dropdown changes
                    dropdownSecondValue = null;
                  });
                },
                items: <String>['Add', 'If', 'If Not']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Tooltip(
                        message: value,
                        child: Container(
                            margin: EdgeInsets.only(left: 1, right: 1),
                            child:
                                Text(value, style: TextStyle(fontSize: 16)))),
                  );
                }).toList(),
              ),
              if (secondDropdownItems != null)
                Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                DropdownButton<String>(
                  value: dropdownSecondValue,
                  underline: SizedBox(
                    height: 0,
                  ),
                  hint: Container(
                      padding: EdgeInsets.only(left: 1),
                      child: Text(
                        'Choose Action',
                        style: TextStyle(fontSize: 16),
                      )),
                  icon: Container(
                      padding: EdgeInsets.only(left: 1),
                      child: Icon(
                        Icons.arrow_drop_down,
                      )),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownSecondValue = newValue;
                    });
                  },
                  items: secondDropdownItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Tooltip(
                          message: value,
                          child: Container(
                              margin: EdgeInsets.only(left: 1, right: 1),
                              child:
                                  Text(value, style: TextStyle(fontSize: 16)))),
                    );
                  }).toList(),
                ),
              ],
            ),
            ],
          ),

            if (secondDropdownItems != null && dropdownNames=='Add')
              Column(
                children: [
                  Padding(padding: EdgeInsets.all(8),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        customArgument = value; // Update the custom variable
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter the argument',
                      ),
                  ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                    if(dropdownSecondValue=='echo'){
                      insertCustomText('${dropdownSecondValue} "${customArgument}";\n');
                    }
                    else if(dropdownSecondValue=='read'){
                      insertCustomText('${dropdownSecondValue} ${customArgument};\n');
                    }
                    else{
                      insertCustomText('${dropdownSecondValue} ${customArgument}\n');
                    }
                    },
                    child: Text('Add to script'),
                  ),
                ],
              ),
              
            if(secondDropdownItems != null && dropdownNames !='Add')
              Column(
                children: [
                  Padding(padding: EdgeInsets.all(8),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        ifArgument = value; // Update the custom variable
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter the argument',
                      ),
                  ),
                  ),

                  DropdownButton<String>(
                value: dropdownThirdValue,
                underline: SizedBox(
                  height: 0,
                ),
                hint: Container(
                    padding: EdgeInsets.only(left: 1),
                    child: Text(
                      'Choose Action',
                      style: TextStyle(fontSize: 16),
                    )),
                icon: Container(
                    padding: EdgeInsets.only(left: 1),
                    child: Icon(
                      Icons.arrow_drop_down,
                    )),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownThirdValue = newValue;
                  });
                },
                items: <String>['echo','cd','ls','cp','mv','rm','mkdir','rmdir','cat','chmod','clear','pwd','wget','which','whoami','chown','read']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Tooltip(
                        message: value,
                        child: Container(
                            margin: EdgeInsets.only(left: 1, right: 1),
                            child:
                                Text(value, style: TextStyle(fontSize: 16)))),
                  );
                }).toList(),
              ),
                  
                  Padding(padding: EdgeInsets.all(8),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        ifThenArgument = value; // Update the custom variable
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter the argument',
                      ),
                  ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (dropdownNames=='If' && dropdownSecondValue=='Argument'){
                        insertCustomText('if ["\${@:-}"="${ifArgument}"]\nthen\n ${dropdownThirdValue} ${ifThenArgument}\nfi\n');
                      }
                      else if(dropdownNames=='If' && dropdownSecondValue=='User Input'){
                        insertCustomText('if ["\${userinput0:-}"="${ifArgument}"]\nthen\n ${dropdownThirdValue} ${ifThenArgument}\nfi\n');
                      }
                      else if(dropdownNames=='If Not' && dropdownSecondValue=='Argument'){
                        insertCustomText('if ["\${@:-}"!="${ifArgument}"]\nthen\n ${dropdownThirdValue} ${ifThenArgument}\nfi\n');
                      }
                      else if(dropdownNames=='If Not' && dropdownSecondValue=='User Input'){
                        insertCustomText('if ["\${userinput0:-}"!="${ifArgument}"]\nthen\n ${dropdownThirdValue} ${ifThenArgument}\nfi\n');
                      }
                    },
                    child: Text('Add to script'),
                  ),
                ],
              ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _textEditingController,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Your script will appear here...',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showAlertDialog(){
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    customVariable = value; // Update the custom variable
                  });
                },
                style: TextStyle(fontSize: 14), // Adjust the font size as needed
                decoration: InputDecoration(
                  labelText: 'Enter Filename',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 5), // Adjust the content padding as needed
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _saveText();
                  Navigator.pop(context);
                  },
                child: Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }


  Future<void> _saveText() async {
    String text = _textEditingController.text;
    if (customVariable.isNotEmpty) {
      if (text.isNotEmpty) {
        final directory = await getApplicationDocumentsDirectory();
        String filePath = '/storage/emulated/0/Download/$customVariable.sh';
        final file = File(filePath);
        await file.writeAsString(text);
        setState(() {
          _savedText = text;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Text saved successfully.\n/storage/emulated/0/Download/')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cannot save an empty text.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot save without a name.')),
      );
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
