export const InjectEnvPlugin = async () => {
  return {
    "shell.env": async (_, output) => {
      // prevent agents from getting `difft` formatted output from `git diff`
      output.env.GIT_EXTERNAL_DIFF =
        'sh -c "diff -u --label "a/$1" --label "b/$1" "$2" "$5" || true" --';
    },
  };
};
