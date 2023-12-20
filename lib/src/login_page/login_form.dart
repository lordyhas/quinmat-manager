part of login_page;

class _EmployeeInput extends StatelessWidget {
  const _EmployeeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return _InputField(key: key,
          icon: FluentIcons.contact,
          hintText: 'Matricule...',
          onChanged: (id) => BlocProvider
            .of<LoginCubit>(context)
            .usernameChanged(id),
          errorText: state.username.invalid ? 'matricule invalide' : null,
          //errorText: state.email.invalid ? 'invalid email' : null,
          validator: (String? text) {
            if (text == null) return null;
            if (text.isEmpty) return null;
            if (text.length < 6) return 'need 6 characters';
            if (text.length > 6) return 'At least 6 characters no more';
            if(state.username.invalid) return 'matricule invalide';

            return null;
          },
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return _InputField(
          key: key,
          icon: FluentIcons.mail,
          hintText: 'Email...',
          isEmail: true,
          onChanged: (email) => BlocProvider
              .of<LoginCubit>(context)
              .emailChanged(email),
          errorText: state.email.invalid ? 'email invalide' : null,
          validator: (String? text) {
            if (text == null) return null;
            if (text.isEmpty) return null;
            if (text.length < 5) return 'At least 5 characters';
            if(state.email.invalid) return 'email invalide';

            return null;
          },
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextFormBox(
            key: widget.key,
            autovalidateMode: AutovalidateMode.always,
            validator: (String? text) {
              if (text == null) return null;
              if (text.isEmpty) return null;
              if (text.length < 8) return 'At least 8 characters';
              if(state.password.invalid) return 'mot de passe invalid';

              return null;
            },
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            style: const TextStyle(color: Colors.white),
            obscureText: showPassword,
            keyboardType: TextInputType.text,
            onChanged: (password) => BlocProvider.of<LoginCubit>(context)
                .passwordChanged(password),
            prefix: Icon(FluentIcons.lock12,size: 18,
              color: Colors.white.withOpacity(.7),
            ),
            suffix: IconButton(
              icon: Icon(showPassword? CupertinoIcons.eye_slash : CupertinoIcons.eye, size: 18,),
              onPressed: (){
                setState(() {
                  showPassword = !showPassword;
                });
              },
            ),

            placeholder: 'Mot de passe...',
            placeholderStyle: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(.5),
            ),
            decoration: BoxDecoration(
              border: Border.all(),
            ),
          ),
        );
        /*return _InputField(
          key: widget.key,
          icon: FluentIcons.lock12,
          hintText:  'Mot de passe...',
          isPassword: showPassword,
          onChanged: (password) =>
              BlocProvider.of<LoginCubit>(context).passwordChanged(password),
          errorText: state.password.invalid ? 'mot de passe invalid' : null,
          suffixIcon: IconButton(
            icon: Icon(showPassword? CupertinoIcons.eye_slash : CupertinoIcons.eye, size: 18,),
            onPressed: (){
              setState(() {
                showPassword = !showPassword;
              });
            },
          ),
        );*/
      },
    );
  }
}


