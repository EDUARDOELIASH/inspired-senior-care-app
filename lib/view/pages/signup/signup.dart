import 'package:email_validator/email_validator.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:inspired_senior_care_app/bloc/onboarding/onboarding_bloc.dart';
import 'package:inspired_senior_care_app/cubits/signup/signup_cubit.dart';
import 'package:inspired_senior_care_app/data/models/user.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: BlocListener<OnboardingBloc, OnboardingState>(
            listener: (context, state) {
              if (state is PageComplete) {
                controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              }
            },
            child: PageView(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                WelcomePage(),
                BasicInfoPage(),
                UserTypePage(),
                ProfileInfo(),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 60,
        color: Colors.grey.shade300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SmoothPageIndicator(
              controller: controller,
              count: 4,
              effect: const WormEffect(spacing: 16),
            )
          ],
        ),
      ),
    );
  }
}

class UserTypePage extends StatelessWidget {
  const UserTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Opacity(
            opacity: 0.05,
            child: Image.asset(
                'lib/assets/backgrounds/Categories_Screenshot.png')),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'What are you?',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 4.0),
                  child: ListTile(
                    minLeadingWidth: 30,
                    onTap: () {
                      BlocListener<OnboardingBloc, OnboardingState>(
                        listener: (context, state) {
                          // TODO: implement listener
                          if (state is OnboardingLoaded) {
                            context.read<OnboardingBloc>().add(UpdateUser(
                                user: state.user.copyWith(type: 'user')));
                          }
                        },
                        child: Container(),
                      );
                      context.read<OnboardingBloc>().add(CompletedPage());
                    },
                    leading: const Icon(
                      Icons.person,
                      size: 28,
                    ),
                    title: const Text('Healthcare Worker'),
                    subtitle: const Text('I just want to learn!'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  child: ListTile(
                    minLeadingWidth: 30,
                    onTap: () {
                      BlocListener<OnboardingBloc, OnboardingState>(
                        listener: (context, state) {
                          // TODO: implement listener
                          if (state is OnboardingLoaded) {
                            context.read<OnboardingBloc>().add(UpdateUser(
                                user: state.user.copyWith(type: 'manager')));
                          }
                        },
                        child: Container(),
                      );
                      context.read<OnboardingBloc>().add(CompletedPage());
                    },
                    leading: const Icon(
                      Icons.security,
                      size: 28,
                    ),
                    title: const Text('I\'m a Manager'),
                    subtitle: const Text(
                        'I\'d like to create groups & view others\' progress.'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Opacity(
              opacity: 0.05,
              child: Image.asset(
                  'lib/assets/backgrounds/Categories_Screenshot.png')),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Welcome!',
                      style: Theme.of(context).textTheme.headline2),
                ),
                const Text(
                    'Learn the what\'s, why\'s, & how\'s of senior care.'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<OnboardingBloc>().add(CompletedPage());
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 32)),
                    child: const Text('Get Started'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BasicInfoPage extends StatefulWidget {
  const BasicInfoPage({Key? key}) : super(key: key);

  @override
  State<BasicInfoPage> createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends State<BasicInfoPage> {
  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();
  late bool hidePassword;
  @override
  void initState() {
    hidePassword = true;
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Stack(
          children: [
            Opacity(
                opacity: 0.05,
                child: Image.asset(
                  'lib/assets/backgrounds/Categories_Screenshot.png',
                )),
            Form(
                key: formKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'First the basics.',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Email Sign Up.',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      SizedBox(
                          width: 325,
                          child: TextFormField(
                            controller: emailFieldController,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              context.read<SignupCubit>().emailChanged(value);
                            },
                            validator: (value) =>
                                value != null && !EmailValidator.validate(value)
                                    ? 'Enter a valid email!'
                                    : null,
                            decoration: InputDecoration(
                                label: const Text('Email Address'),
                                prefixIcon: const Icon(Icons.email_rounded),
                                suffixIcon: IconButton(
                                    onPressed: () =>
                                        emailFieldController.clear(),
                                    icon: const Icon(Icons.close))),
                          )),
                      /*  Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Create a Password',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),*/
                      const SizedBox(
                        height: 12.0,
                      ),
                      SizedBox(
                        width: 325,
                        child: TextFormField(
                          controller: passwordFieldController,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            label: const Text('Password'),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                icon: hidePassword
                                    ? const Icon(Icons.visibility_off_rounded)
                                    : const Icon(Icons.visibility_rounded)),
                          ),
                          onChanged: (value) {
                            context.read<SignupCubit>().passwordChanged(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(
                          height: 70,
                          child: FlutterPwValidator(
                              width: 300,
                              height: 50,
                              minLength: 6,
                              uppercaseCharCount: 1,
                              specialCharCount: 1,
                              onSuccess: () {},
                              controller: passwordFieldController),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                            onPressed: () async {
                              final form = formKey.currentState;

                              if (form!.validate()) {
                                await context
                                    .read<SignupCubit>()
                                    .signupWithCredentials();
                                // TODO: Implement Signup Cubit
                                // * Create Initial User Object
                                if (!mounted) return;
                                User user = User(
                                    id: context
                                        .read<SignupCubit>()
                                        .state
                                        .user!
                                        .uid,
                                    name: '',
                                    email: emailFieldController.text,
                                    type: '',
                                    title: '',
                                    userColor: '');
                                // * Pass User to Onboarding Bloc
                                context
                                    .read<OnboardingBloc>()
                                    .add(StartOnboarding(user: user));
                                context
                                    .read<OnboardingBloc>()
                                    .add(CompletedPage());
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.redAccent,
                                        content:
                                            Text('Invalid Email Entered!')));
                              }
                            },
                            child: const Text('Continue')),
                      ),
                    ],
                  ),
                )),
          ],
        );
      },
    );
  }
}

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  // create some values
  // Color for the picker shown in Card on the screen.
  late Color screenPickerColor;
  // Color for the picker in a dialog using onChanged.
  late Color dialogPickerColor;
  // Color for picker using the color select dialog.
  late Color dialogSelectColor;

  @override
  void initState() {
    super.initState();
    screenPickerColor = Colors.blue; // Material blue.
    dialogPickerColor = Colors.red; // Material red.
    dialogSelectColor = const Color(0xFFA239CA); // A purple color.
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Opacity(
            opacity: 0.05,
            child: Image.asset(
                'lib/assets/backgrounds/Categories_Screenshot.png')),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'You\'re Almost Done!',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'What\'s Your Name?',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              SizedBox(
                width: 325,
                child: TextFormField(
                  decoration: const InputDecoration(label: Text('Your Name')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'What\'s Your Title?',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              const SizedBox(
                width: 325,
                child: TextField(
                  decoration: InputDecoration(label: Text('Title')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Card(
                  child: ColorPicker(
                    color: screenPickerColor,
                    onColorChanged: (Color selectedColor) =>
                        setState(() => screenPickerColor = selectedColor),
                    borderRadius: 22,
                    heading: Text(
                      'Choose a Color',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    subheading: Text(
                      'Pick a Shade',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                child: ListTile(
                  title: Text(
                    'Currently Selected Color:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: const Text('Choose a color for your profile'),
                  trailing: ColorIndicator(
                    borderRadius: 22,
                    color: screenPickerColor,
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {}, child: const Text('Finish Setup')),
            ],
          ),
        ),
      ],
    );
  }
}
