export const AppLayout = ({ children }) => {
  return (
    <div className="grid grid-cols-[300px_1fr] h-screen max-h-screen">
      <div className="flex flex-col overflow-hidden text-white">
        <div className="bg-slate-800">
          <div>lofo</div>
          <div>cta</div>
          <div>tokens</div>
        </div>
        <div className="flex-1 overflow-auto bg-gradient-to-b from-slate-800 to-cyan-600">
          List post
        </div>
        <div className="bg-cyan-600">user info</div>
      </div>
      <div>{children}</div>
    </div>
  );
};
