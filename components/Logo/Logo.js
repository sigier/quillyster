import Image from "next/image";

export const Logo = () => {
  return (
    <div className="relative flex flex-col items-center text-white py-4 font-heading">
      <span className="text-4xl font-bold text-center tracking-wider relative z-10">
        Quillyster
      </span>
      <div className="absolute -top-4 right-0 translate-x-2">
        <Image
          src="/logo.png"
          alt="Metallic quill logo"
          width={60}
          height={60}
          className="z-0"
        />
      </div>
    </div>
  );
};
