import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/utils/utils.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  @override
  //disposing the password and email
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

/*
  selectImage() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
  }
*/
  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 1,
              ),
              //instagram image
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              //circular widget to accept and show our selected file
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64.0,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64.0,
                          backgroundImage: NetworkImage(
                            'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAIIAggMBIgACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAABQYDBAcBAv/EADQQAAICAAMEBwYGAwAAAAAAAAABAgMEBREGIUFxEhMxM1FhcjI1kbGywSJSgaHR4SNCYv/EABkBAQEBAQEBAAAAAAAAAAAAAAADBAIBBf/EACIRAQEAAQQBBQEBAAAAAAAAAAABAgMEESExEjJBQlEiE//aAAwDAQACEQMRAD8AvAAPuvmgAAAAAAAAAAAAAAAAAAAAAAAAAAAAACNzPOcPgW4LW278keHNkHdtDjrG+rddS4dGKb/fUpjpZ5dx5cpFuBTq8/zGD1ldCxeE64/ZIlsBtFTc1DFQ6mT3dJb4/wBHuWhnj28mcqbB4mmtVvR6SdAAAAAAAAAAAAAARWfZi8FQq6n/AJrVuf5VxZKlJzy935pe+EJdBLlu/kro4erLtzneI0m23q3q32t8TwA+giAACf2bzKULI4K6TcJd03/q/DkWU55GThNTi9JReqfmX/D2K6iu1dk4KXxRh3GExy5iuF56ZAAQdgAAAAAAAAAAFDzGLhmOJi+3rZfMvhVNp8G6sYsVFfguWjfhJf19y+3ykz4cZzpDAA3JAAAF7y2Ljl2Gi+1VR+RTcuwksbjaqIrc3rJ+EeJe1okkloZNzlOoppz5AAZVAAAAAAAAAAADFisNXi6JU3LWEv280ZQBScxyvEYCb6cXOrhZFbv18DR1OiNJpppNPtTNC7Jsvul0pYdJvjBuPyNWG549ydw/FKM2Fwt2Ls6vD1uT4vgub4FsryLLoPXqOl6ptm/VVXTBQqhGEVwitD3Lcz6w/wA78tPKcthl1OntXS9ufj5LyN8Ay223mqToAB4AAAAAAAAABH5tmleX1padO6S/DD7s9ktvELeG9OcK4udkoxiu1yeiRF4naHBU7q3O6X/EdF8WVjGYzEY2fTxFjl4LguSMBqw20+ydz/E9btNc+5w9cfU2zWltDj5Pc6o8oEUC00cJ8OfVUotoMwT9ut84IzV7S4uPeU0z5JohQLpYfh6qs9G0tEt19NlfnF9JEthcZh8XHXD2xn4pPev0KEewlKuSnCTjJdkovRonltsb4ezOx0MFeyfPXOcaMc97ekbfF+f8lhMmeFwvFUl5AAcvQAAAAAKFjr5YnGXXTerlN6eS4L4F9Zz2feT9TNO1ndrjUfIANiQAAAAAAAAy7ZLfPEZZROx6yS6Lfjo9PsUkuOznuinnL6mZtzP5ld4eUmADGqAAAAAD7DntneT9TOhPsOe2d5P1M1bXzU9R8gA1pgAAAAAAABcdnPdFPOX1MpxcdnPdFPOX1Mz7n2x3h5SYAMSoAAAAAPsOe2d5P1MA1bXzU9R8gA1pgAAAAAAABcdnPdFPOX1MAz7n2x3h5SYAMSoAAP/Z',
                          ),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 64,
              ),
              //text field input for username
              TextFieldInput(
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              const SizedBox(
                height: 24.0,
              ),
              // text field email
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(
                height: 24.0,
              ),
              // text field password
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextFieldInput(
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
                textEditingController: _bioController,
              ),
              const SizedBox(
                height: 24.0,
              ),
              //button login
              InkWell(
                onTap: signUpUser,
                child: Center(
                  child: Container(
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            )
                          : const Text('Sign up'),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        color: blueColor,
                      ),),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an account? "),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: const Text(
                        "Login.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                    ),
                  ),
                ],
              ),
              // Transitioning to sign up
            ],
          ),
        ),
      ),
    );
  }
}
