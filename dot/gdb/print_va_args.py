import gdb
import sys


class PrintVaArgs(gdb.Command):
    "Command to print va_args (print-va VA_LIST COUNT)"

    def __init__(self):
        super(PrintVaArgs, self).__init__(
            "print-va",
            gdb.COMMAND_DATA,
            gdb.COMPLETE_NONE,
            True
        )

    def invoke(self, arg, from_tty):
        argv = gdb.string_to_argv(arg)
        if not argv:
            sys.stderr.write("usage: va-print VA_LIST [COUNT | TYPE...]")
            return
        ap = argv[0]
        if len(argv) == 1 or len(argv) > 1 and argv[1].isdigit():
            count = 1 if len(argv) == 1 else int(argv[1])
            if len(argv) == 2:
                self.va_args_by_count(ap, count)
            else:
                self.va_args_by_types(ap, [argv[2]] * count)
        else:
            self.va_args_by_types(ap, argv[1:])

    def va_args_by_count(self, ap, count):
        for i in range(count):
            cmd = f'x/c ({ap}[0].reg_save_area + {ap}[0].gp_offset + {8 * i})'
            self.execute(cmd)

    def va_args_by_types(self, ap, arg_types):
        for i, arg_type in enumerate(arg_types):
            pointer = f'({ap}[0].reg_save_area + {ap}[0].gp_offset + {8 * i})'
            cmd = f'p *({arg_type}*)'
            self.execute(cmd + pointer)

    def execute(self, command):
        output = gdb.execute(command, True, True)
        sys.stdout.write(output)


PrintVaArgs()
