import logoUrl from "../../assets/logo.svg";
import { Input } from "@/components/ui/input";
import { Card, CardContent, CardHeader } from "../../components/ui/card";
import { Label } from "@/components/ui/label";
import { Button } from "../../components/ui/Button";
import { ThemeToggle } from "../../components/ordinary/ThemeToggle";
import { useForm, SubmitHandler } from "react-hook-form";
import { auth } from "../../api/users";
import { Checkbox } from "../../components/ui/checkbox";

type Inputs = {
  email: string;
  password: string;
  rememberMe: boolean;
};

export const SignIn = () => {
  const {
    register,
    handleSubmit,
    watch,
    formState: { errors },
  } = useForm<Inputs>();
  const onSubmit: SubmitHandler<Inputs> = async (data) => {
    const res = await auth(data);

    console.log(res);
  };

  return (
    <div className="h-screen w-screen flex justify-center items-center">
      {/* <img src={logoUrl} width={80} className="absolute left-2 top-2" /> */}
      <div className="absolute right-2 top-2">
        <ThemeToggle />
      </div>
      <Card className="min-w-[320px]">
        <CardHeader />
        <CardContent>
          <form
            className="flex flex-col gap-4"
            onSubmit={handleSubmit(onSubmit)}
          >
            <Label htmlFor="email">Почта</Label>
            <Input
              id="email"
              type="email"
              placeholder="example@mail.ru"
              {...register("email", {
                required: true,
              })}
            />
            <Label htmlFor="password">Пароль</Label>
            <Input
              id="password"
              type="password"
              placeholder="••••••••"
              {...register("password", {
                required: true,
              })}
            />
            <div className="flex items-center space-x-2">
              <Checkbox id="rememberMe" {...register("rememberMe")} />
              <label
                htmlFor="rememberMe"
                className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
              >
                Запомнить меня
              </label>
            </div>
            <Button className="w-full" type="submit">
              Войти
            </Button>
          </form>
        </CardContent>
      </Card>
    </div>
  );
};
