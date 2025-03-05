import { withPageAuthRequired } from "@auth0/nextjs-auth0";
import { AppLayout } from "../components/AppLayout";
import { getAppProps } from "../utils/getAppProps";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faCoins } from "@fortawesome/free-solid-svg-icons";

export default function TokenTopup({ availableTokens }) {
  const handleClick = async () => {
    const result = await fetch(`/api/addTokens`, {
      method: "POST",
    });
    const json = await result.json();
    window.location.href = json.session.url;
  };

  return (
    <div className="flex flex-col items-center justify-center h-screen text-center">
      <FontAwesomeIcon icon={faCoins} className="text-yellow-500 text-4xl" />
      <h1 className="text-2xl font-bold mt-4">
        You have {availableTokens} tokens available
      </h1>
      <p className="text-gray-600">1 token = 1 blog post</p>
      <button
        className="bg-green-500 text-white font-semibold px-6 py-3 rounded-lg mt-6 hover:bg-green-600 disabled:opacity-50"
        onClick={handleClick}
      >
        {"BUY 10 TOKENS FOR $1"}
      </button>
    </div>
  );
}

TokenTopup.getLayout = function getLayout(page, pageProps) {
  return <AppLayout {...pageProps}>{page}</AppLayout>;
};

export const getServerSideProps = withPageAuthRequired({
  async getServerSideProps(ctx) {
    const props = await getAppProps(ctx);
    return {
      props,
    };
  },
});
