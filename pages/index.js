import Image from "next/image";
import HeroImage from "../public/hero.webp";
import { Logo } from "../components/Logo/Logo";
import Link from "next/link";

export default function Home() {
  return (
    <div className="w-screen h-screen overflow-hidden flex justify-center items-center relative backdrop-blur-sm">
      <Image
        src={HeroImage}
        alt="Hero"
        fill
        className="absolute object-cover"
      />

      <div className="relative z-10 flex flex-col items-center text-white px-10 py-5 text-center max-w-screen-sm bg-slate-900/90 rounded-md">
        <Logo />
        <p className="mb-2">
          Welcome to Quillyster! Discover the magic of words.
        </p>
        <Link className="btn" href="/post/new">
          Begin
        </Link>
      </div>
    </div>
  );
}
