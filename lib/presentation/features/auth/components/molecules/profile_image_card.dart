import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../domain/constants/language_constants.dart';
import '../../../../../domain/models/user/user.dart';
import '../../../../core/services/user_service.dart';
import '../../../user/bloc/bloc_user.dart';
import '../../../user/components/organism/my_avatar.dart';

class ProfileImageCard extends StatefulWidget {
  const ProfileImageCard({super.key});

  @override
  State<ProfileImageCard> createState() => _ProfileImageCardState();
}

class _ProfileImageCardState extends State<ProfileImageCard> {
  File? _image;
  bool _uploading = false;
  Widget? _uploadedImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              _buildImageWidget(),
              Positioned(
                bottom: 0,
                right: 4,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _buildUploadButton(),
                    ),
                    color: Theme.of(context).colorScheme.secondary,
                    iconSize: 50,
                    onPressed: _image == null
                        ? () async {
                      await _showImageSourceOptions();
                    }
                        : _uploading
                        ? null
                        : _uploadImage,
                  ),
                ),
              ),// mostramos el botón de subir solo si no hay imagen
              if (_image != null) // mostramos el botón de borrar solo si hay una imagen
                Positioned(
                  top: 0,
                  right: 4,
                  child: Visibility(
                    visible: !_uploading,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        color: Colors.white,
                        iconSize: 34,
                        onPressed: _deleteImage,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildImageWidget() {
    if (_image == null) {
      if (_uploadedImage != null) {
        return _uploadedImage!;
      }
      else if (User.getInstance().imageUrl != '') {
        //print(User.getInstance().imageUrl);
        return MyAvatar(size: 180,imageUrl: User.getInstance().imageUrl??'');
      } else {
        return _buildPlaceholderAvatar();
      }
    } else {
      return ClipOval(
        child: SizedBox(
          width: 180,
          height: 180,
          child: Image.file(
            _image!,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }



  Widget _buildPlaceholderAvatar() {
    return CircleAvatar(
      radius: 90,
      //backgroundColor: Color.fromRGBO(0, 82, 151, 0.2),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.15),
      child: const Icon(
        Icons.account_circle,
        color: Colors.white,
        size: 180,
      ),
    );
  }

  Widget _buildUploadButton() {
    if (_uploading) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).colorScheme.secondary,
        ),
      );
    } else {
      return _image == null ? Icon(Icons.camera_alt,color: Theme.of(context).colorScheme.primary,) : Icon(Icons.save,color: Theme.of(context).colorScheme.primary,);
    }
  }

  Future<void> _showImageSourceOptions() async {
    String? result = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return _buildImageSourceOptions();
      },
    );

    if (result == 'camera') {
      await _getImageFromCamera();
    } else if (result == 'gallery') {
      await _pickImageFromGallery();
    }
  }

  Widget _buildImageSourceOptions() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildImageSourceOption(
            icon: Icons.camera_alt,
            title: translation(context)!.take_a_photo,
            onPressed: () async {
              Navigator.pop(context, 'camera');
            },
          ),
          _buildImageSourceOption(
            icon: Icons.image,
            title: translation(context)!.choose_a_image_from_your_gallery,
            onPressed: () async {
              Navigator.pop(context, 'gallery');
            },
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  translation(context)!.back_label,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String title,
    required VoidCallback onPressed,
  }) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> _getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image != null) {
      setState(() {
        _uploading = true;
      });

      await _image!.readAsBytes().then((imageBytes) {
        final base64Image = base64Encode(imageBytes);

        UserService(context).updateUserImage(
          base64Image,
          User.getInstance().personData!.uMobileID,
        ).then((value) {

          _uploadedImage = ClipOval(
            child: SizedBox(
              width: 180,
              height: 180,
              child: Image.memory(imageBytes, fit: BoxFit.cover),
            ),
          );
          if (mounted) {
            setState(() {
              _uploading = false;
              _image = null;
            });
          }
          ImageCache().clear();

          CachedNetworkImage(
            imageUrl: User.getInstance().imageUrl.toString(),
            placeholder: (context, url) => Center(child: LinearProgressIndicator(color: Theme.of(context).colorScheme.primary,)),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          );
          UserService(context).loadGeneralData();

          BlocProvider.of<BlocUser>(context).updateImagePerfil(User.getInstance().imageUrl.toString());
          precacheImage(
            NetworkImage(User.getInstance().imageUrl.toString()),
            context,
            onError: (exception, stackTrace) {
              //print('Error preloading image: $exception');
            },
          );
        });
      });

    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _deleteImage() {
    setState(() {
      _image = null;
    });
  }
}
