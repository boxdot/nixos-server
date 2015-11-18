{
  "activesupport" = {
    version = "4.2.5";
    source = {
      type = "gem";
      sha256 = "1w2znchjbgzj3sgp0581q15rikcj1cji80ki2ky8fwdnjxlh54mb";
    };
    dependencies = [
      "i18n"
      "json"
      "minitest"
      "thread_safe"
      "tzinfo"
    ];
  };
  "i18n" = {
    version = "0.7.0";
    source = {
      type = "gem";
      sha256 = "1i5z1ykl8zhszsxcs8mzl8d0dxgs3ylz8qlzrw74jb0gplkx6758";
    };
  };
  "json" = {
    version = "1.8.3";
    source = {
      type = "gem";
      sha256 = "1nsby6ry8l9xg3yw4adlhk2pnc7i0h0rznvcss4vk3v74qg0k8lc";
    };
  };
  "kramdown" = {
    version = "1.9.0";
    source = {
      type = "gem";
      sha256 = "12sral2xli39mnr4b9m2sxdlgam4ni0a1mkxawc5311z107zj3p0";
    };
  };
  "logutils" = {
    version = "0.6.1";
    source = {
      type = "gem";
      sha256 = "18r9yaz0k0z7v47clxa289znvqja9k1g133pg0ddxw5dm2mcwvd3";
    };
  };
  "markdown" = {
    version = "1.2.0";
    source = {
      type = "gem";
      sha256 = "06z0443w7rpg00zwwc6fzqp483h0alga8lwyvpqfrm4c9fk71sgd";
    };
    dependencies = [
      "kramdown"
      "props"
      "textutils"
    ];
  };
  "minitest" = {
    version = "5.8.3";
    source = {
      type = "gem";
      sha256 = "0kfcmxz8rf7qdbxzhq6mzsq1dx8ghvw2nfx2ky46fcdglpzis6v8";
    };
  };
  "props" = {
    version = "1.1.2";
    source = {
      type = "gem";
      sha256 = "1m2qjsy1gpkfx3y843q9skw8bvr9mq0xwyawsmlgafmpdbq61pc4";
    };
  };
  "rubyzip" = {
    version = "1.1.7";
    source = {
      type = "gem";
      sha256 = "0cq1ckjhyzh97fm5xs899fjjy3szpdh0y4bc3kngdf2yy29prar4";
    };
  };
  "textutils" = {
    version = "1.3.1";
    source = {
      type = "gem";
      sha256 = "1znia8v05dgg93s2a6mmkdn5jhq8qk2qm0smbw5iwcy42vk0fxbi";
    };
    dependencies = [
      "activesupport"
      "logutils"
      "props"
      "rubyzip"
    ];
  };
  "thread_safe" = {
    version = "0.3.5";
    source = {
      type = "gem";
      sha256 = "1hq46wqsyylx5afkp6jmcihdpv4ynzzq9ygb6z2pb1cbz5js0gcr";
    };
  };
  "tzinfo" = {
    version = "1.2.2";
    source = {
      type = "gem";
      sha256 = "1c01p3kg6xvy1cgjnzdfq45fggbwish8krd0h864jvbpybyx7cgx";
    };
    dependencies = [
      "thread_safe"
    ];
  };
}