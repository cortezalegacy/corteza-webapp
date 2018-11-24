<?php

error_reporting(E_ALL^E_NOTICE);

include(__DIR__ . "/vendor/autoload.php");

function capitalize($name) {
	$names = explode("/", $name);
	return implode("", array_map("ucfirst", $names));
}

function camel($name) {
	return lcfirst(implode("", array_map("ucfirst", explode("_", $name))));
}

function uncamel($name) {
	$result = "";
	$name = lcfirst(str_replace("ID", "_id", $name));
	for ($i = 0; $i < strlen($name); $i++) {
		if ($name{$i} === strtoupper($name{$i})) {
			$result .= "_" . strtolower($name{$i});
			continue;
		}
		$result .= $name{$i};
	}
	return $result;
}

list($self, $class, $spec, $output) = $argv;

$data = array(
	"class" => $class,
	"endpoints" => json_decode(file_get_contents($spec), true),
);

$sections = array();

function listSectionOnly($section, $data) {
	foreach ($data['endpoints'] as $endpoint => $params) {
		foreach ($params['apis'] as $key => $api) {
			if ($api['section'] !== $section) {
				unset($params['apis'][$key]);
			}
		}
		$data['endpoints'][$endpoint] = $params;
	}
	return $data;
}

foreach ($data['endpoints'] as $endpoint => $params) {
	foreach ($params['apis'] as $key => $api) {
		$api['link'] = trim($params['path'], "/") . "/" . trim($api['path'], "/");
		$api['link'] = str_replace("{", '${', $api['link']);

		$api['call'] = $params['entrypoint'] . capitalize($api['name']);

		$section = explode("_", uncamel($api['call']));

		$api['callShort'] = ucfirst($section[count($section) - 1]);
		$api['section'] = $section[count($section) - 2];
		$api['callSection'] = $api['section'] . $api['callShort'];

		var_dump(implode("/", $section) . " -> " . $api['callSection']);

		$sections[$api['section']] = true;

		$arguments = $get = $post = array();
		foreach (array("path", "get", "post") as $method) {
			$inputs = array();
			if (!empty($params['parameters'][$method])) {
				$inputs = array_merge($inputs, $params['parameters'][$method]);
			}
			if (!empty($api['parameters'][$method])) {
				$inputs = array_merge($inputs, $api['parameters'][$method]);
			}
			if (!empty($inputs)) {
				foreach ($inputs as $input) {
					$arguments[] = $input['name'];
					if ($method === "path") {
						continue;
					}
					if ($method === "get") {
						$get[] = $input['name'];
					} else {
						$post[] = $input['name'];
					}
				}
			}
		}
		$api['data'] = $post;
		$api['params'] = $get;
		$api['arguments'] = implode(", ", array_map("camel", $arguments));

		$params['apis'][$key] = $api;
	}
	$data['endpoints'][$endpoint] = $params;
}

$tpl = new Monotek\MiniTPL\Template;
$tpl->set_compile_location("/tmp", true);
$tpl->add_default("newline", "\n");

$tpl->load("plugin.tpl");
$tpl->assign($data);
file_put_contents($output, trim($tpl->get()) . "\n");
echo $output . "\n";

foreach ($sections as $section => $tmp) {
	unset($tmp);
	$tpl->load("store.tpl");
	$tpl->assign(listSectionOnly($section, $data));
	@mkdir("api/" . strtolower($class));
	file_put_contents("api/" . strtolower($class) . "/" . $section . ".js", trim($tpl->get()) . "\n");
}