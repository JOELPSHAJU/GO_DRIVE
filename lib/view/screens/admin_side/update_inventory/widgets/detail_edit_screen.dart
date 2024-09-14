// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/snakbars.dart';
import 'package:godrive/model/car_model.dart';
import 'package:godrive/view/bloc/get_car_data/getcardata_bloc.dart';
import 'package:godrive/view/bloc/get_car_data/getcardata_event.dart';
import 'package:godrive/view/bloc/update_inventory/update_inventory_bloc.dart';
import 'package:godrive/view/screens/admin_side/add_inventory/widgets/dropdown_category.dart';
import 'package:godrive/view/screens/admin_side/add_inventory/widgets/dropdown_company.dart';
import 'package:godrive/view/screens/admin_side/add_inventory/widgets/dropdown_fueltype.dart';
import 'package:godrive/view/screens/admin_side/add_inventory/widgets/dropdown_transmission.dart';
import 'package:godrive/view/screens/admin_side/add_inventory/widgets/inputs_add_inventory.dart';
import 'package:godrive/view/screens/universal_widgets/heading.dart';
import 'package:godrive/view/screens/universal_widgets/loading_button.dart';
import 'package:image_picker/image_picker.dart';

final ValueNotifier<String?> selectedCompanyedit = ValueNotifier<String?>(null);
final ValueNotifier<String?> selectedCategoryedit =
    ValueNotifier<String?>(null);
final ValueNotifier<String?> selectedfueltypeedit =
    ValueNotifier<String?>(null);
final ValueNotifier<String?> selectedtransmissiontypeedit =
    ValueNotifier<String?>(null);

class UpdateDetailsScreen extends StatelessWidget {
  UpdateDetailsScreen({super.key, required this.carData}) {
    selectedCompanyedit.value = carData['companyName'] ?? 'null' ?? '';
    selectedCategoryedit.value = carData['category'] ?? 'null';
    selectedfueltypeedit.value = carData['fuelType'] ?? 'null';
    selectedtransmissiontypeedit.value = carData['transmissionType'] ?? 'null';
    modelnamecontroller.text = carData['modelName'] ?? 'null';
    enginedisplacementcontroller.text = carData['engineDisplacement'] ?? 'null';
    maxpowercontroller.text = carData['maxPower'] ?? 'null';
    maxtorquecontroller.text = carData['maxTorque'] ?? 'null';
    zerotohndrdcontroller.text = carData['zeroToHundred'] ?? 'null';
    seatingcapacitycontroller.text = carData['seatingCapacity'] ?? 'null';
    numberplatecontroller.text = carData['numberPlate'] ?? 'null';
    fueltankcapacitycontroller.text = carData['fuelTankCapacity'] ?? 'null';
    groundclearencecontroller.text = carData['groundClearance'] ?? 'null';
    gearboxcontroller.text = carData['gearbox'] ?? 'null';
    overviewcontroller.text = carData['overview'] ?? 'null';
    documentId = carData['id'];
    priceperdaycontroller.text = carData['pricePerDay'] ?? 'null';
    displaymainimage = carData['mainImage'] ?? 'null';
    for (var image in carData['additionalImages']) {
      displayAdditionalImages.add(image);
    }
  }
  List<String> displayAdditionalImages = [];
  String displaymainimage = '';
  final Map<String, dynamic> carData;
  final ValueNotifier<String> pickImageEdit = ValueNotifier('');
  final ValueNotifier<List<String>> pickImagesEdit = ValueNotifier([]);
  late XFile? file;
  late List<XFile> imgfiles = [];
  String documentId = '';
  TextEditingController modelnamecontroller = TextEditingController();
  TextEditingController enginedisplacementcontroller = TextEditingController();
  TextEditingController maxpowercontroller = TextEditingController();
  TextEditingController maxtorquecontroller = TextEditingController();
  TextEditingController zerotohndrdcontroller = TextEditingController();
  TextEditingController seatingcapacitycontroller = TextEditingController();
  TextEditingController numberplatecontroller = TextEditingController();
  TextEditingController fueltankcapacitycontroller = TextEditingController();
  TextEditingController groundclearencecontroller = TextEditingController();
  TextEditingController gearboxcontroller = TextEditingController();
  TextEditingController overviewcontroller = TextEditingController();
  TextEditingController priceperdaycontroller = TextEditingController();
  final formKeyeditinventory = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: white),
          backgroundColor: black,
          surfaceTintColor: black,
          centerTitle: true,
          title: const Text(
            'EDIT INVENTORY',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: white),
          ),
        ),
        body: BlocProvider(
            create: (context) => UpdateInventoryBloc(),
            child: BlocListener<UpdateInventoryBloc, UpdateInventoryState>(
                listener: (context, state) {
              if (state is UpdateInventoryLoadingState) {
              } else if (state is UpdateInventorySucessState) {
                modelnamecontroller.clear();
                pickImageEdit.value = '';
                pickImagesEdit.value = [];
                selectedfueltypeedit.value = null;
                selectedtransmissiontypeedit.value = null;
                selectedCompanyedit.value = null;
                selectedCategoryedit.value = null;
                enginedisplacementcontroller.clear();
                maxpowercontroller.clear();
                maxtorquecontroller.clear();
                zerotohndrdcontroller.clear();
                seatingcapacitycontroller.clear();
                numberplatecontroller.clear();
                fueltankcapacitycontroller.clear();
                groundclearencecontroller.clear();
                gearboxcontroller.clear();
                overviewcontroller.clear();
                priceperdaycontroller.clear();
                imgfiles.clear();
                file = null;

                context.read<CarDetailsBloc>().add(FetchCarDetails());
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: green50,
                    content: Text('Upload Successful!'),
                  ),
                );
              } else if (state is UpdateInventoryErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      backgroundColor: red, content: Text('Upload Failed!')),
                );
              }
            }, child: BlocBuilder<UpdateInventoryBloc, UpdateInventoryState>(
                    builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'Inventory Main Image',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder<String>(
                        valueListenable: pickImageEdit,
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () async {
                              try {
                                file = await ImagePicker().pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (file != null) {
                                  pickImageEdit.value = file!.path;
                                }
                              } catch (e) {
                                if (kDebugMode) {
                                  print('Error picking image: $e');
                                }
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 150,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color.fromARGB(
                                              255, 228, 228, 228),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                          offset: Offset(0, 2))
                                    ],
                                    color: white,
                                  ),
                                  child: pickImageEdit.value.isEmpty
                                      ? CachedNetworkImage(
                                          placeholder: (context, url) {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                color: black,
                                              ),
                                            );
                                          },
                                          imageUrl: displaymainimage,
                                          fit: BoxFit.fitWidth,
                                        )
                                      : Image.file(
                                          File(pickImageEdit.value),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                if (pickImageEdit.value.isNotEmpty)
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          pickImageEdit.value = '';
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: red,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Inventory Additional Images',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder<List<String>>(
                        valueListenable: pickImagesEdit,
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () async {
                              try {
                                imgfiles = await ImagePicker().pickMultiImage();
                                if (imgfiles.isNotEmpty) {
                                  pickImagesEdit.value = imgfiles
                                      .map((file) => file.path)
                                      .toList();
                                }
                              } catch (e) {
                                if (kDebugMode) {
                                  print('Error picking images: $e');
                                }
                              }
                            },
                            child: Wrap(
                              spacing: 10,
                              children: pickImagesEdit.value.isEmpty
                                  ? displayAdditionalImages.map((image) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 228, 228, 228),
                                                blurRadius: 10,
                                                spreadRadius: 2,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                            color: white,
                                          ),
                                          child: CachedNetworkImage(
                                            placeholder: (context, url) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: black,
                                                ),
                                              );
                                            },
                                            imageUrl: image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }).toList()
                                  : pickImagesEdit.value.map((imagePath) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Color.fromARGB(
                                                          255, 228, 228, 228),
                                                      blurRadius: 10,
                                                      spreadRadius: 2,
                                                      offset: Offset(0, 2))
                                                ],
                                                color: white,
                                              ),
                                              child: Image.file(
                                                File(imagePath),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 5,
                                              right: 5,
                                              child: GestureDetector(
                                                onTap: () {
                                                  pickImagesEdit.value =
                                                      pickImagesEdit.value
                                                          .where((path) =>
                                                              path != imagePath)
                                                          .toList();
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                    color: white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: red,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                            ),
                          );
                        },
                      ),
                      h20,
                      const Heading(heading: 'Company Name'),
                      h10,
                      DropdownCompany(
                          selectedCompany: selectedCompanyedit, size: size),
                      h20,
                      const Heading(heading: 'Category'),
                      h10,
                      DropdownCategory(
                          selectedCategory: selectedCategoryedit, size: size),
                      h20,
                      const Heading(heading: 'Fuel Type'),
                      h10,
                      DropdownFuelType(
                          selectedfueltype: selectedfueltypeedit, size: size),
                      h20,
                      const Heading(heading: 'Transmission Type'),
                      h10,
                      DropdownTransmission(
                          selectedtransmission: selectedtransmissiontypeedit,
                          size: size),
                      h20,
                      const Heading(heading: 'Model Name'),
                      Form(
                        key: formKeyeditinventory,
                        child: InputsAddInventory(
                            modelnamecontroller: modelnamecontroller,
                            enginedisplacementcontroller:
                                enginedisplacementcontroller,
                            maxpowercontroller: maxpowercontroller,
                            maxtorquecontroller: maxtorquecontroller,
                            zerotohndrdcontroller: zerotohndrdcontroller,
                            seatingcapacitycontroller:
                                seatingcapacitycontroller,
                            numberplatecontroller: numberplatecontroller,
                            fueltankcapacitycontroller:
                                fueltankcapacitycontroller,
                            gearboxcontroller: gearboxcontroller,
                            priceperdaycontroller: priceperdaycontroller,
                            groundclearencecontroller:
                                groundclearencecontroller,
                            overviewcontroller: overviewcontroller),
                      ),
                      h20,
                      BlocBuilder<UpdateInventoryBloc, UpdateInventoryState>(
                        builder: (context, state) {
                          if (state is UpdateInventoryLoadingState) {
                            return loadingButton(
                                media: size, onPressed: () {}, color: black);
                          }
                          return MaterialButton(
                            color: black,
                            minWidth: MediaQuery.of(context).size.width,
                            height: 55,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              if (formKeyeditinventory.currentState!
                                  .validate()) {
                                CarModel carModel = CarModel(
                                  modelName: modelnamecontroller.text,
                                  engineDisplacement:
                                      enginedisplacementcontroller.text,
                                  maxPower: maxpowercontroller.text,
                                  maxTorque: maxtorquecontroller.text,
                                  zeroToHundred: zerotohndrdcontroller.text,
                                  seatingCapacity:
                                      seatingcapacitycontroller.text,
                                  numberPlate: numberplatecontroller.text,
                                  fuelTankCapacity:
                                      fueltankcapacitycontroller.text,
                                  groundClearance:
                                      groundclearencecontroller.text,
                                  gearbox: gearboxcontroller.text,
                                  overview: overviewcontroller.text,
                                  pricePerDay: priceperdaycontroller.text,
                                  mainImage: displaymainimage,
                                  additionalImages: displayAdditionalImages,
                                  companyName:
                                      selectedCompanyedit.value.toString(),
                                  category:
                                      selectedCategoryedit.value.toString(),
                                  fuelType:
                                      selectedfueltypeedit.value.toString(),
                                  transmissionType: selectedtransmissiontypeedit
                                      .value
                                      .toString(),
                                );
                                String updateimagemain =
                                    pickImageEdit.value.toString();
                                List<String> updateimageadditional = [];
                                if (pickImagesEdit.value.isNotEmpty) {
                                  for (var img in pickImagesEdit.value) {
                                    updateimageadditional.add(img.toString());
                                  }
                                }
                                context.read<UpdateInventoryBloc>().add(
                                    UpdateCarDetails(
                                        documentId: documentId,
                                        additionalImages: updateimageadditional,
                                        mainimage: updateimagemain,
                                        updatedData: carModel));
                              } else {
                                warningSnakbar(context, 'Fill All Fields', red);
                              }
                            },
                            child: const Text('Update Inventory',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                    fontSize: 17)),
                          );
                        },
                      ),
                      h40,
                    ],
                  ),
                ),
              );
            }))));
  }
}
