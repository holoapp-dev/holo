import { Button, Card, InputLabel, InputText } from "../../components/ui";
import logoUrl from "../../assets/logo.svg";

export const SignIn = () => {
  return (
    <div className="h-screen w-screen flex justify-center items-center">
      <img src={logoUrl} width={80} className="absolute left-2 top-2" />
      <Card className="min-w-[320px]">
        <div className="flex flex-col gap-4 ">
          <InputLabel>
            Почта
            <InputText type="email" placeholder="example@mail.ru" />
          </InputLabel>
          <InputLabel>
            Пароль
            <InputText type="password" placeholder="••••••••" />
          </InputLabel>
          <Button className="w-full">Войти</Button>
        </div>
      </Card>
    </div>
  );
};
