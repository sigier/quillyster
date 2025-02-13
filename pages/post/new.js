import { withPageAuthRequired } from "@auth0/nextjs-auth0";
import { AppLayout } from "../../components/AppLayout/AppLayout";
import { useState } from "react";
import Markdown from "react-markdown";

export default function NewPost(props) {
  const [postContent, setPostContent] = useState("");

  const handleSubmit = async () => {
    const response = await fetch(`/api/generatePost`, {
      method: "POST",
      headers: {
        "content-type": "application/json",
      },
      body: JSON.stringify({ topic, keywords }),
    });
    const json = await response.json();
    setPostContent(json.postContent);
  };

  return <Markdown>{postContent}</Markdown>;
}

NewPost.getLayout = function getLayout(page, pageProps) {
  return <AppLayout {...pageProps}>{page}</AppLayout>;
};

export const getServerSideProps = withPageAuthRequired(() => {
  return {
    props: {},
  };
});
