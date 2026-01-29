import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/functions/pick_file.dart';
import '../../../../../core/widgets/custom_field.dart';
import 'audio_wave.dart';

class UploadSong extends ConsumerStatefulWidget {
  const UploadSong({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadSongState();
}

class _UploadSongState extends ConsumerState<UploadSong> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController artistController = TextEditingController();
  Color selectedColor = AppColors.cardColor;
  File? selectedAudio;
  File? selectedImage;

  @override
  void dispose() {
    nameController.dispose();
    artistController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Song'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.check_rounded))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  final pickedImage = await pickFile(FileType.image);
                  if (pickedImage != null) {
                    setState(() {
                      selectedImage = pickedImage;
                    });
                  }
                },
                child: selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                          height: 150,
                          width: double.infinity,
                        ),
                      )
                    : const DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          radius: Radius.circular(10),
                          color: AppColors.borderColor,
                          dashPattern: [10, 4],
                          strokeCap: StrokeCap.round,
                        ),
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_open_rounded, size: 40),
                              SizedBox(height: 15),
                              Text(
                                'Select the thumbnail for your song',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 40),
              selectedAudio != null
                  ? AudioWave(path: selectedAudio!.path)
                  : CustomField(
                      readOnly: true,
                      hint: 'Pick Song',
                      onTap: () async {
                        final pickedAudio = await pickFile(FileType.audio);
                        if (pickedAudio != null) {
                          setState(() {
                            selectedAudio = pickedAudio;
                          });
                        }
                      },
                    ),
              const SizedBox(height: 15),
              CustomField(
                controller: nameController,
                hint: 'Song Name',
                validator: (value) {
                  return null;
                },
              ),
              const SizedBox(height: 15),
              CustomField(
                controller: artistController,
                hint: 'Artist',
                validator: (value) {
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ColorPicker(
                pickersEnabled: {ColorPickerType.wheel: true},
                color: selectedColor,
                onColorChanged: (color) => setState(() {
                  selectedColor = color;
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
