part of login_page;

class ButtonLogin extends StatelessWidget {
  final String text;

  const ButtonLogin({this.text = 'LOGIN', Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return GestureDetector(
          //highlightColor: Colors.transparent,
          //splashColor: Colors.transparent,
          onTap: () {
            if (state.status.isValidated) {
              context.read<LoginCubit>().logInWithCredentials();
            }
          },
          child: BooleanBuilder(
            condition: () {
              return state.status.isSubmissionInProgress;
            },
            ifTrue: const SizedBox.square(
              dimension: 40,
              child: ProgressRing(), //activeColor: FluentTheme.of(context).activeColor,
            ),
            ifFalse: Container(
              height: 40,
              width: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: state.status.isValidated
                    ? FluentTheme.of(context).accentColor
                    : Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          ),
        );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  final String text;

  const _GoogleLoginButton({this.text = "Sign in with Google"});

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width *0.75;
    //final theme = FluentTheme.of(context);
    Widget googleOutlineButton = OutlinedButton(
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
      //BlocProvider.of<LoginCubit>(context).logInWithGoogle(),
      style: ButtonStyle(
        shape: ButtonState.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        )),
        border: ButtonState.all(BorderSide(
          width: 2,
          color: FluentTheme.of(context).activeColor,
        )),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              FontAwesomeIcons.google,
              size: 18,
            ),
            const Spacer(),
            Text(text),
            const Spacer(),
            const Icon(
              FontAwesomeIcons.google,
              color: Colors.transparent,
            ),
          ],
        ),
      ),
    );
    return Container(child: googleOutlineButton);
  }
}

class _FacebookLoginButton extends StatelessWidget {
  final String text;

  const _FacebookLoginButton({this.text = "Sign in with Facebook"});

  @override
  Widget build(BuildContext context) {
    Widget facebookOutlineButton = OutlinedButton(
        key: const Key('loginForm_facebookLogin_outlineButton'),
        style: ButtonStyle(
          shape: ButtonState.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          )),
          border: ButtonState.all(BorderSide(
            width: 2,
            color: FluentTheme.of(context).activeColor,
          )),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                FontAwesomeIcons.facebookF,
                size: 18,
              ),
              const Spacer(),
              Text(text),
              const Spacer(),
              const Icon(
                FontAwesomeIcons.facebookF,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
        onPressed: () {} //=> context.bloc<LoginCubit>().logInWithFacebook(),
        );

    return Container(child: facebookOutlineButton);
  }
}

class _InputField extends StatelessWidget {
  final IconData icon;
  final Widget? suffixIcon;
  final String hintText;
  final bool isPassword;
  final bool isEmail;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? errorText;

  const _InputField({
    required this.icon,
    this.hintText = '',
    this.isPassword = false,
    this.isEmail = false,
    this.onChanged,
    this.validator,
    this.errorText,
    this.suffixIcon,
    Key? key,
  })  : asContainer = false,
        textBox = const SizedBox.shrink(),
        super(key: key);

  final bool asContainer;
  final Widget textBox;

  const _InputField.container({
    required TextFormBox child,
    Key? key,
  })  : icon = FluentIcons.admin,
        hintText = '',
        isPassword = false,
        isEmail = false,
        onChanged = null,
        validator = null,
        errorText = null,
        suffixIcon = null,
        asContainer = true,
        textBox = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Container(
      //height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        children: [
          if (asContainer)
            textBox
          else
            TextFormBox(
              autovalidateMode: AutovalidateMode.always,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              key: key,
              validator: validator,
              style: const TextStyle(color: Colors.white),
              obscureText: isPassword,
              keyboardType:
                  isEmail ? TextInputType.emailAddress : TextInputType.text,
              onChanged: onChanged,
              prefix: Icon(
                icon,
                size: 18,
                color: Colors.white.withOpacity(.7),
              ),
              suffix: suffixIcon,
              placeholder: hintText,
              placeholderStyle: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(.5),
              ),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
            ),
        ],
      ),
    );
  }
}
